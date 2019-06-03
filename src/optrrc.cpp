#include "optrrc.hpp"
#include <omp.h>
#include <vector>
#include <nlopt.hpp>

void OptRRC::optimize()
{
	int num_thread;
	if(nthread == 0)
	{
		num_thread = omp_get_max_threads();
	}
	else
	{
		num_thread = nthread;
	}
	
	opt_rrc_case optcase = empty;
	while(!check_terminate(optcase))
	{
		#pragma omp parallel num_threads(num_threads)
		for(size_t i = 0; i < nstart_point; i++)
		{
			nlopt::opt opt = set_optimizer();
			if(is_init(i))
			{
				MatrixXd xopt_m = get_rand_matrix(1);
			}
			VectorXd xopt_prev = xopt_m.col(0);
			std::vector<double> xopt_v = eig_to_vec_v(xopt_prev);
			try
			{
				opt.optimize(xopt_v, f)
			}
			catch(std::exception& e)
			{}
			sp.col(i) = vec_to_eig_v(xopt_v);
			spf(i) = f;
			if(sdist_vv(sp.col(i), xopt_prev) < 1e-3)
			{
				is_init[i] = true;
			}
			else
			{
				is_init[i] = false;
			}
		}
	}
}

nlopt::opt OptRRC::set_optimizer()
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
	nlopt_opt.set_min_objective([](const vector<double>& x, 
							vector<double>& grad,
							void* data)->double
	{
		return(run_func(vec_to_eig_v(x)));
	}, NULL);
	return opt;
};

bool OptRRC::check_terminate(opt_rrc_case& optcase)
{
	double delta_t = ostats.get_elapsed_time();
	bool is_end = false;
	if(optcase == fail)
	{
		is_end = true;
		log << "[opt]\t" << "fail" << endl;
	}
	else if((max_update > 0) && (get_n_new_sample() >= max_update))
	{
		optcase = onestep;
		is_end = true;
		log << "[opt]\t" << "opt hits onestep update." << endl;
	}
	else
	{
		is_end = false;
		optcase = empty;
		log << "[opt]\t" << "opt continue." << endl;
	}
	return is_end;
};
