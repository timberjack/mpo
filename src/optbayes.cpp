#include "optbayes.hpp"

// samples stored as [-1 1] sub-domain format
void OptBayes::initialize(MatrixXd x, VectorXd f)
{
	// check for dimension mismatches
	check_invalid({static_cast<size_t>(x.rows()) != dim,
			x.cols() != f.size()}, "initialize", "input dimension mismatches with problem dimension.");

	// make sure number of samples bigger than init_nsample
	MatrixXd initx = x;
	VectorXd initf = f;
	if(x.cols() < init_nsample)
	{
		unsigned int nextra = init_nsample - (unsigned int)(x.cols());
		MatrixXd mextra = get_rand_matrix((size_t)nextra);
		VectorXd fextra = run_func(mextra);
		initx.conservativeResize(NoChange, initx.cols() + nextra);
		initx.rightCols(nextra) = mextra;
		initf.conservativeResize(initf.size() + nextra);
		initf.tail(nextra) = fextra;
	}

	// check for inf and nan errors
	check_invalid({!initf.allFinite()}, "initialize", "inf or nan value exists in samples");

	// init gp model
	bayes_init();
	initx = rescale(initx, gp_bound);

	log << "[opt]\t" << "optbayes is init with " 
		<< initx.cols() << " samples."  << endl;

	matrixd mx_u = eig_to_ublas_m(move(initx));
	vectord mf_u = eig_to_ublas_v(move(initf));

	gp->setSamples(mx_u);
	gp->setSamples(mf_u);
	train_gp(true);

	sp = MatrixXd::Constant(dim, nstart_point, 0);
	spf = VectorXd::Constant(nstart_point, 0);
	crit.assign(nstart_point, 0.0);
	is_init.assign(nstart_point, true);
	is_imp.assign(nstart_point, false);
	is_conv.assign(nstart_point, false);
	nsp_wo_imp = 0;
};

void OptBayes::initialize()
{
	MatrixXd mx = get_rand_matrix(init_nsample);
	VectorXd mf = run_func(mx);
	initialize(mx, mf);
};

void OptBayes::bayes_init()
{
	//bayesopt::Parameters par;
	par = initialize_parameters_to_default();
	par.crit_name = "cLCB";
	par.random_seed = seed;
	par.noise = 1e-10;
	par.sc_type = SC_MAP;
	par.verbose_level = 0;
	par.sigma_s = sigma;
	par.l_all = 1;
	par.kernel.name = "kMaternARD5";
	boost::mt19937 mengine;
	mengine.seed(par.random_seed);
	gp.reset(bayesopt::PosteriorModel::create(dim, par, mengine));
};

OptBayes::opt_bayes_case OptBayes::optimize()
{
	check_invalid({!gp.get()}, "optimize", "gp not initialized");
	
	// OpenMP threads
	int num_thread;
	if(nthread == 0)
	{
		num_thread = omp_get_max_threads();
	}
	else
	{
		num_thread = nthread;
	}
	
	opt_bayes_case optcase = empty;
	t1 = high_resolution_clock::now();
	while(!check_terminate(optcase))
	{
		// local search on GP predicted lower confidence bound (lcb)
		int ninit = 0;
		for(size_t i = 0; i < nstart_point; i++)
		{
			if(is_init[i])
			{
				ninit++;	
			}
		}
		MatrixXd temp = get_rand_matrix(ninit);
		VectorXd tempf = run_func(temp);
		int ntemp = 0;
		for(size_t i = 0; i < nstart_point; i++)
		{
			if(is_init[i])
			{
				log << "[opt]\t" << "sp " << i
				<< " randomly sampled." << endl;
				sp.col(i) = temp.col(ntemp);
				spf(i) = tempf(ntemp);
				ntemp++;
				is_init[i] = false;
			}
		}
		
		#pragma omp parallel for schedule(dynamic), num_threads(num_thread)
		for(size_t i = 0; i < nstart_point; i++)
		{
			nlopt::opt opt = set_optimizer(gp);
			VectorXd xopt_prev = sp.col(i);
			vector<double> xopt_vec = eig_to_vec_v(rescale(xopt_prev, gp_bound));
			try
			{
				opt.optimize(xopt_vec, crit[i]);
			}
			catch(std::exception& e)
			{}
			VectorXd xopt = unscale(vec_to_eig_v(xopt_vec), gp_bound);
			outofbound_check(xopt);			
			sp.col(i) = xopt;
			if(sdist_vv(xopt, xopt_prev) < 1e-3)
			{
				is_conv[i] = true;
				log << "[opt]\t " << "xopt_prev: " << xopt_prev << endl;
				log << "[opt]\t " << "xopt: " << xopt << endl; 
			}
			else
			{
				is_conv[i] = false;
			}
		};

		if(optcase == fail)
		{
			continue;
		}
		
		// if searched sample points in multiple-thread are very close
		// only keep one, delete others
		check_close();
		spf = run_func(sp);

		// retrain GP model based on newly acquired sample points
		for(size_t i = 0; i < nstart_point; i++)
		{
			if(!is_conv[i])
			{
				vectord xopt_u = eig_to_ublas_v(rescale(sp.col(i), gp_bound));
				gp->addSample(xopt_u, spf(i));
				train_gp();
			}
		}
		log << "[opt]\t" << "after sample." << endl;
		monitor();

		// if sample fails to find local lcb better than global optimal
		// if so, allow sample point to stop local search to acquire a random
		// sample point

		for(size_t i = 0; i < nstart_point; i++)
		{
			// if crit not optimal than global optimal
			// add lcb_no_improve
			if(crit[i] > (ref_best_f - 0.1 * abs(ref_best_f)))
			{
				lcb_no_improve[i]++;
				log << "[opt]\t" << "sp " << i << " does not improve for "
					<< lcb_no_improve[i] << " times." << endl;
			}
			else
			{
				lcb_no_improve[i] = 0;
				is_imp[i] = true;
				log << "[opt]\t" << "sp " << i
					<< " local search attempt makes improvement."
					<< endl;
			}

			// if lcb_no_improve goes beyond limit
			// reset start point to a random sample
			// if an improvement happens, reset nsp_wo_imp to 
			if((lcb_no_improve[i] >= ls_end_num) || (is_conv[i]))
			{
				is_init[i] = true;
				lcb_no_improve[i] = 0;
				is_conv[i] = false;
				if(is_imp[i])
				{
					nsp_wo_imp = 0;
					log << "[opt]\t" << "sp " << i
					<< " local search ends with improvement."
					<< endl;
				}
				else
				{
					nsp_wo_imp++;
					log << "[opt]\t" << "sp " << i
					<< " local search ends without improvement, "
					<< "in consecutive " << nsp_wo_imp 
					<< " times now." << endl; 
				}
				is_imp[i] = false;
			}
		}
		log << "[opt]\t" << "after check." << endl;
		monitor();
		log << "[opt]\t" << "best_f: " << get_best_f() << endl;
		log << "[opt]\t" << "ref_best_f: " << get_ref_best_f() << endl;
		log << "[opt]\t" << "nsample: " << get_n_new_sample() << endl;
	}
	log << "[opt]\t" << "local search result:" << endl;
	log << "[opt]\t" << "best_x: " << get_best_x().transpose() << endl;
	log << "[opt]\t" << "best_f: " << get_best_f() << endl;
	log << "[opt]\t" << "ref_best_f: " << get_ref_best_f() << endl;

	return optcase;
};

void OptBayes::train_gp(bool force_relearn)
{
	//auto train_start = chrono::high_resolution_clock::now();
	double t1 = ostats.get_elapsed_time();
	size_t nsample = gp->getData()->getNSamples();
	if((force_relearn) || (nsample - n_trained_sample) > relearn_nsample)
	{
		gp->updateHyperParameters();
		gp->fitSurrogateModel();
		n_trained_sample = nsample;
		log << "[opt]\t" << "gp retrained for " << ostats.get_elapsed_time() - t1 << " s."<< endl;
	}
	else
	{
		gp->updateSurrogateModel();
	}
	//auto train_end = chrono::high_resolution_clock::now();
	//const double time_train = duration_cast<chrono::milliseconds>(train_end - train_start).count()/1000;
	hyp = ublas_to_eig_v(gp->getHyperParameters());
	for(size_t i = 0; i < hyp.size(); i++)
	{
		hyp(i) = exp(hyp(i));
	}
	log << "hyp: " << hyp << endl;
};

nlopt::opt OptBayes::set_optimizer(
			boost::shared_ptr<bayesopt::PosteriorModel> gp_t)
{
	// TODO recheck BOBYQA hack points
	nlopt::opt opt(nlopt::LN_COBYLA, dim);
	opt.set_maxeval(50);
	opt.set_lower_bounds(0 - numeric_limits<double>::epsilon());
	opt.set_upper_bounds(1 + numeric_limits<double>::epsilon());
	opt.set_ftol_rel(1e-4);
	opt.set_ftol_abs(1e-4);
	opt.set_xtol_rel(1e-4);
	opt.set_xtol_abs(1e-4);
	opt.set_initial_step(1e-1);
	reset_gp_objective(opt, gp_t);
	return opt;
};

void OptBayes::reset_gp_objective(nlopt::opt& nlopt_opt,
			boost::shared_ptr<bayesopt::PosteriorModel> gp_t)
{
	check_invalid({gp.get() == 0}, "set_optimizer", "gp not initialized");
	nlopt_opt.set_min_objective([](const vector<double>& x,
					vector<double>& grad,
					void* data)->double
	{
		bayesopt::PosteriorModel* opt = reinterpret_cast<bayesopt::PosteriorModel*>(data);
		vectord x_u(x.size());
		copy(x.begin(), x.end(), x_u.begin());
		return(opt->evaluateCriteria(x_u));
	}, (void*)(gp.get()));
};

double OptBayes::tester(const vector<double>& x, void* data)
{
	boost::scoped_ptr<bayesopt::PosteriorModel> opt;
	opt.reset(reinterpret_cast<bayesopt::PosteriorModel*>(data));
	vectord x_u(x.size());
	copy(x.begin(), x.end(), x_u.begin());
	cout << "x_u " << x_u << endl;
	return(opt->evaluateCriteria(x_u));
};

VectorXd OptBayes::get_hyp()
{
	return hyp;
};

VectorXd OptBayes::get_hyp_ls()
{
	//check_invalid({(par.kernel.name != "kMaternARD1")&&
	//	(par.kernel.name == "kMaternARD3")&&
	//	(par.kernel.name == "kMaternARD5")},
	//	"get_hyp_ls", "lengthscale not supported.");
	
	if(par.l_all)
	{
		return hyp.segment(0, dim);
	}
	else
	{
		return hyp;
	}
};

bool OptBayes::check_terminate(opt_bayes_case& optcase)
{
	t2 = high_resolution_clock::now();
	const double elapse_t 
		= duration_cast<chrono::milliseconds>(t2 - t1).count()/1000;
	bool is_end = false;
	if(optcase == fail)
	{
		is_end = true;
		log << "[opt]\n" << "fail" << endl;
	}
	else if(nsp_wo_imp >= msp_end_num)
	{
		optcase = complete;
		is_end = true;
		log << "[opt]\t" << "opt local search complete." << endl;
	}
	else if((region_max_nsample > 0) && (get_size() >= region_max_nsample))
	{
		optcase = incomplete;
		is_end = true;
		log << "[log]\t" << "nsample in region reaches max limit." << endl;
		log << "[log]\t" << "opt local search incomplete." << endl;
	}
	else if((max_update > 0)&&(get_n_new_sample() >= max_update))
	{
		optcase = onestep;
		is_end = true;
		log << "[opt]\t" << "opt hits onestep update." << endl;
	}
	else
	{
		log << "[opt]\t" << "opt continue." << endl;
		optcase = empty;
		is_end = false;
	}
	return is_end;
};

void OptBayes::check_close()
{
	//monitor_x();
	for(size_t i = 0; i < sp.cols(); i++)
	{
		MatrixXd sp_c = sp.leftCols(i);
		int m_idx;
		int sp_idx;
		MatrixXd m(dim, get_x().cols() + sp_c.cols());
		m.leftCols(get_x().cols()) = get_x();
		m.rightCols(sp_c.cols()) = sp_c;
		if(sdist_vm(sp.col(i), m).minCoeff(&m_idx) < 1e-4) 
		{

			double range = scaled_ub - scaled_lb;
			normal_distribution<double> dist(-1e-3 * range, 1e-3 * range);
			for(size_t d = 0; d < dim; d++)
			{
				sp.col(i)(d) += dist(engine);
				sp.col(i)(d) = max(min(sp.col(i)(d), scaled_ub), scaled_lb);
			}
		}
	}
};

void OptBayes::monitor()
{
	log << "----------------------------------------------" << endl;
	log << "[opt]\t" 
		<< setw(10) << "spf" 
		<< setw(10) << "crit" 
		<< setw(10) << "is_init" 
		<< setw(10) << "is_imp" 
		<< setw(10) << "is_conv"
		<< setw(10) << "lcb_no_improve" << endl;
	for(size_t i = 0; i < nstart_point; i++)
	{
		log << "[opt]\t" 
			<< setw(10) << spf(i) 
			<< setw(10) << crit[i]
   		    << setw(10) << is_init[i] 
			<< setw(10) << is_imp[i]
			<< setw(10) << is_conv[i]
		    << setw(10) << lcb_no_improve[i] << endl;
		//std::cout << rescale(sp.col(i), rbound) << endl;
	}
	log << "[opt]\t" << "ref_best_f: " << ref_best_f << endl;
	log << "[opt]\t" << "nsp_wo_imp: " << nsp_wo_imp << endl;
	log << "[opt]\t" << "nnew: "  << get_n_new_sample() << endl;
	log << "[opt]\t" << "n_trained_sample: " << n_trained_sample << endl;
	log << "[opt]\t" << "nsample: " << get_size() << endl;
	log << "----------------------------------------------" << endl;
};

void OptBayes::monitor_x()
{
	std::cout << "x:\t\t\t" << "f\t" << "r\t\t\t"<< endl;
	for(size_t i = 0; i < get_x().cols(); i++)
	{
		//cout << mx.col(i).transpose() << "\t" << rescale(mx.col(i).transpose(), rbound).transpose() << "test " << mf(i) << endl;
		cout << get_f()(i) << endl;
	}
}

void OptBayes::set_param(Config& config)
{
	// init gp
	sigma = config.sigma;
	init_nsample = max(config.min_init_sample, (int)(10 * dim));
	msp_end_num = config.msp_end_num;
	ls_end_num = config.ls_end_num;
	min_lcb_diff = config.min_lcb_diff;
	nthread = config.nthread;
	nstart_point = config.nstart_point;
	max_update = config.max_update;
	region_max_nsample = config.region_max_nsample;

	sp = MatrixXd::Constant(dim, nstart_point, 0);
	spf = VectorXd::Constant(dim, 0);
	crit.assign(nstart_point, 0.0);
	is_init.assign(nstart_point, true);
	is_imp.assign(nstart_point, false);
	is_conv.assign(nstart_point, false);
	lcb_no_improve.assign(nstart_point, 0);
}

