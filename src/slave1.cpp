#include "slave1.hpp"

void Slave1::run()
{
	bool is_on = true;
	while(is_on)
	{
		is_on = handler();
	}
};

void Slave1::single_run(int ntrial)
{
	makedir("experiment");
	oconfig.read("setting.ini");
	bound = get_default_bound(oconfig.dim);
	if(oconfig.method == "bayesopt")
	{
		set_problem();
		for(size_t i = 0; i < ntrial; i++)
		{
			set_optbayes();
			const string log_name = opt_bayes->set_stats(true);
			opt_bayes->initialize();
			opt_bayes->optimize();
			opt_bayes->solution();
			copyto(log_name, "experiment/stats" + to_string(i) + ".log");
			removefile(log_name);
			clean();
		}
	}
};

void Slave1::setup_slave_dir()
{
	/* check if work folder exists */
	if(isexist(work_path))
	{
		removedir(work_path);
	}	

	/* create folder */
	string cmd = "mkdir -p " + work_path;
	int n = system(cmd.c_str());

	/* copy designeasy list to folder */
	copyto("de.ini", work_path);
	
	/* define folder as work path */
	n = chdir(work_path.c_str());
};

void Slave1::setup_single_dir()
{
	/* check if slave folder exists */
	if(isexist(work_path))
	{
		removedir(work_path);
	}
	
	/* create master folder */
	string cmd = "mkdir -p " + work_path;
	int n = system(cmd.c_str());

	/* copy setting file to folder */
	copyto("setting.ini", work_path);
	copyto("de.ini", work_path);

	/* define folder as work path */
	n = chdir(work_path.c_str());
};

bool Slave1::handler()
{
	bool is_on = true;
	bool is_recv = true;
	bool is_x_recv = false;
	bool is_f_recv = false;
	bool is_problem_recv = false;
	bool is_tool_recv = false;
	MatrixXd mx, mf;
	double global_best_f;
	msg nextmove;
	mpi::status msg_status = world.probe();
	int rank = msg_status.source();
	while(is_recv)
	{
		mpi::status msg_status = world.probe(rank, mpi::any_tag);
		int n;
		switch(msg_status.tag())
		{
			case msg::squery:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::squery;
				is_recv = false;
				break;
			case msg::srandom:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::srandom;
				clear_data();
				break;
			case msg::strain:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::strain;
				clear_data();
				break;
			case msg::sinitopt:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::sinitopt;
				clear_data();
				break;
			case msg::sopt:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::sopt;
				break;
			case msg::swait:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::swait;
				clear_data();
				break;
			case msg::sstop:
				mrecv(world, root, msg_status.tag(), n);
				nextmove = msg::sstop;
				clear_data();
				break;
			case msg::dbound:
				mrecv(world, root, msg_status.tag(), bound);
				break;
			case msg::dx:
				mrecv(world, root, msg_status.tag(), mx);
				is_x_recv = true;
				break;
			case msg::df:
				mrecv(world, root, msg_status.tag(), mf);
				is_f_recv = true;
				if((is_x_recv) && (is_f_recv))
				{
					add_data(move(unscale(mx, bound)), move(mf.col(0)));
					is_x_recv = false;
					is_f_recv = false;
				}
				break;
			case msg::dgfmin:
				mrecv(world, root, msg_status.tag(), global_best_f);
				add_gmin_f(global_best_f);
				break;
			case msg::oproblem:
				mrecv(world, root, msg_status.tag(), oconfig.problem);
				is_problem_recv = true;
				break;
			case msg::otool:
				mrecv(world, root, msg_status.tag(), oconfig.tool);
				is_tool_recv = true;
				if((is_problem_recv) && (is_tool_recv))
				{
					set_problem();
					is_problem_recv = false;
					is_tool_recv = false;
				}
				break;
			case msg::omethod:
				mrecv(world, root, msg_status.tag(), oconfig.method);
				break;
			case msg::onumrandsample:
				mrecv(world, root, msg_status.tag(), oconfig.num_random_sample);
				break;
			case msg::omininitsample:
				mrecv(world, root, msg_status.tag(), oconfig.min_init_sample);
				break;
			case msg::oregionmaxnsample:
				mrecv(world, root, msg_status.tag(), oconfig.region_max_nsample);
				break;
			case msg::osigma:
				mrecv(world, root, msg_status.tag(), oconfig.sigma);
				break;
			case msg::omspendnum:
				mrecv(world, root, msg_status.tag(), oconfig.msp_end_num);
				break;
			case msg::olsendnum:
				mrecv(world, root, msg_status.tag(), oconfig.ls_end_num);
				break;
			case msg::ohyptype:
				mrecv(world, root, msg_status.tag(), oconfig.hyptype);
				break;
			case msg::omaxupdate:
				mrecv(world, root, msg_status.tag(), oconfig.max_update);
				break;
			case msg::ominlcbdiff:
				mrecv(world, root, msg_status.tag(), oconfig.min_lcb_diff);
				break;
			case msg::onstartp:
				mrecv(world, root, msg_status.tag(), oconfig.nstart_point);
				break;
			case msg::onthread:
				mrecv(world, root, msg_status.tag(), oconfig.nthread);
				break;
			case msg::eend:
				mrecv(world, root, msg_status.tag(), n);
				is_recv = false;
				break;
			default:
				cerr << "[error] " << "slave " << "invalid tag " 
				<< explain_msg(msg_status.tag()) << endl;
				exit(1);
		}
	}

	print_log_end();

	//std::cout << "nextmove: " << explain_msg(msg::strain) << std::endl;

	if(nextmove == msg::squery)
	{
		do_squery();
	}
	else if(nextmove == msg::srandom)
	{
		do_srand();
	}
	else if(nextmove == msg::strain)
	{
		do_strain();
	}
	else if(nextmove == msg::sinitopt)
	{
		if(oconfig.method == "bayesopt")
		{
			do_init_optbayes();
		}
	}
	else if(nextmove == msg::sopt)
	{
		if(oconfig.method == "bayesopt")
		{
			do_optbayes();
		}
	}
	else if(nextmove == msg::swait)
	{
		do_wait();
	}
	else if(nextmove == msg::sstop)
	{
		do_stop();
		is_on = false;
	}
	return is_on;
}

void Slave1::do_squery()
{
	msend(world, root, msg::rquery, 1);

	if(status == pstatus::hang)
	{
		status = pstatus::queue;
	}
	print_log_end();
};

void Slave1::do_srand()
{
	MatrixXd mx;
	VectorXd mf;

	// random samples
	opt_base.reset(new OptBase(odataset, oconfig.func, bound, oconfig.rbound, seed));
	opt_base->rand_sample(oconfig.num_random_sample, mx, mf);

	// reply random samples to master
	// data should map to overall normalized domain
	msend(world, root, msg::rrandom, 1);
	msend(world, root, msg::dx, rescale(mx, bound));
	msend(world, root, msg::df, mf);
	msend(world, root, msg::eend, 1);
	log << "[DEBUG]\t" << get_nsample() << endl;
	//log << "[send]\t" << "send rrandom to root." << endl;
	print_log_end();
};

void Slave1::do_strain()
{	
	if(oconfig.method == "bayesopt")
	{
			opt_bayes.reset(new OptBayes(odataset, oconfig.func, bound, oconfig.rbound, seed));
			opt_bayes->initialize(get_x(), get_f());
			if(oconfig.hyptype == "hyp")
			{
				VectorXd hyp_d = opt_bayes->get_hyp();
				msend(world, root, msg::rtrain, 1);
				msend(world, root, msg::dhyp, hyp_d);
				msend(world, root, msg::eend, 1);
				log << "[DEBUG]\t" << get_nsample() << endl;
				print_log_end();
			}
			else if(oconfig.hyptype == "hyp_ls" )
			{
				VectorXd hyp_ls_d = opt_bayes->get_hyp_ls();
				msend(world, root, msg::rtrain, 1);
				msend(world, root, msg::dhyp_ls, hyp_ls_d);
				msend(world, root, msg::eend, 1);
				log << "[DEBUG]\t" << get_nsample() << endl;
				print_log_end();
			}
	}
};

void Slave1::set_optbayes()
{
	// init gp
	opt_bayes.reset(
	new OptBayes(odataset, oconfig.func, bound, oconfig.rbound, seed));
	opt_bayes->set_param(oconfig);
	/*opt_bayes->sigma = oconfig.sigma;
	opt_bayes->init_nsample = oconfig.min_init_sample;
	opt_bayes->msp_end_num = oconfig.msp_end_num;
	opt_bayes->ls_end_num = oconfig.ls_end_num;
	opt_bayes->ter_max_duration = oconfig.max_duration;
	opt_bayes->min_lcb_diff = oconfig.min_lcb_diff;
	opt_bayes->nthread = oconfig.nthread;
	opt_bayes->set_nstart_point(oconfig.nstart_point);
	if(mode == "slave")
	{
		opt_bayes->max_update = oconfig.max_update;
	}
	else if(mode == "single")
	{
		opt_bayes->max_update = 0;
	}*/
};

void Slave1::set_problem()
{
	if(oconfig.tool == "designeasy")
	{
		oconfig.read_de("de.ini");
		oconfig.source = oconfig.problemlist[oconfig.problem];
		setDE(oconfig.source, oconfig.hspice, oconfig.problem);
	}
	else if(oconfig.tool == "math")
	{
		oconfig.source = "";
	}
	oconfig.func = get_func(oconfig.problem, oconfig.tool, 
						oconfig.source, oconfig.dim, oconfig.rbound);
	reset_data(oconfig.dim);
};

void Slave1::do_init_optbayes()
{
	// init gp
	MatrixXd mx;
	VectorXd mf;
	set_optbayes();
	opt_bayes->initialize(get_x(), get_f());
	opt_bayes->move_new_sample(mx, mf);

	// reply 
	MatrixXd mm;
	msend(world, root, msg::ropt, 1);
	msend(world, root, msg::opt_onestep, 1);
	if(mx.cols() > 0)
	{
		msend(world, root, msg::dx, rescale(mx, bound));
		msend(world, root, msg::df, mf);
	}
	if(oconfig.hyptype == "hyp")
	{
		msend(world, root, msg::dhyp, opt_bayes->get_hyp());
	}
	else
	{
		msend(world, root, msg::dhyp_ls, opt_bayes->get_hyp_ls());
	}
	msend(world, root, msg::eend, 1);
	print_log_end();
};

void Slave1::do_optbayes()
{
	// check if opt_bayes is initialized
	check_invalid({!opt_bayes.get()}, "do_optbayes", "bayesopt is not created.");

	// opt	
	MatrixXd mx;
	VectorXd mf;
	OptBayes::opt_bayes_case rcase = opt_bayes->optimize();
	opt_bayes->move_new_sample(mx, mf);
	VectorXd hyp = opt_bayes->get_hyp();

	// reply to root
	msend(world, root, msg::ropt, 1);
	if(rcase == OptBayes::onestep)
	{
		msend(world, root, msg::opt_onestep, 1);
	}
	else if(rcase == OptBayes::complete)
	{
		msend(world, root, msg::opt_complete, 1);
	}
	else if(rcase == OptBayes::incomplete)
	{
		msend(world, root, msg::opt_incomplete, 1);
	}
	else if(rcase == OptBayes::fail)
	{
		msend(world, root, msg::opt_fail, 1);
	}
	if(mx.cols() > 0)
	{
		msend(world, root, msg::dx, rescale(mx, bound));
		msend(world, root, msg::df, mf);
	}
	msend(world, root, msg::dhyp, hyp);
	msend(world, root, msg::eend, 1);
};

void Slave1::do_wait()
{
	opt_base.reset();
	opt_bayes.reset();
	status = pstatus::hang;
};

void Slave1::do_stop()
{
	// empty for now
};

void Slave1::clean()
{
	odataset->reset_data(oconfig.dim);
};

