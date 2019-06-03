#ifndef _OPTBAYES_
#define _OPTBAYES_

#include <iostream>
#include "posteriormodel.hpp"
#include "bayesopt/parameters.hpp"
#include <boost/scoped_ptr.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/make_shared.hpp>
#include "nlopt.hpp"
#include <Eigen/Dense>
#include "utils.hpp"
#include "optbase.hpp"
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cmath>
#include <omp.h>
#include <vector>
#include "stats.hpp"
#include <iomanip>
#include "config.hpp"
#include <algorithm>

using namespace Eigen;
using namespace std;
using namespace std::chrono;

class OptBayes: public OptBase
{
public:
	/* options */
	unsigned int sigma;
	unsigned int init_nsample;	// minimum number of initial random samples
	unsigned int relearn_nsample;	// amount of samples to trigger a gp relearn
	unsigned int nstart_point;	// number of start points each turn
	unsigned int nthread;		// number of threads, 0 for automatic assignments

	/* local search termination clause */
	unsigned int msp_end_num;	// max number of attempts to find not-optimal lcb
	unsigned int ls_end_num;
	
	unsigned int n_trained_sample;
	unsigned int n_max_ls;
	unsigned int region_max_nsample;
	
	/* global search termination clause */
	double min_lcb_diff;

	unsigned int max_update;

private:
	/* time measurement */
	high_resolution_clock::time_point t1;
	high_resolution_clock::time_point t2;

	boost::shared_ptr<bayesopt::PosteriorModel> gp;
	MatrixXd gp_bound;

	/* parameters */
	bayesopt::Parameters par;

	/* hyperparameters */
	VectorXd hyp;

	/* variable */
	MatrixXd sp;			// start point
	VectorXd spf;	

	vector<double> crit;
	vector<bool> is_init;
	vector<bool> is_imp;		// is improved during local search
	vector<unsigned int> lcb_no_improve;
	vector<bool> is_conv;
	unsigned int nsp_wo_imp;
		
		// number of (consecutive) start points without an improvement
	
public:
	OptBayes(boost::shared_ptr<Dataset> dataset, Func func, MatrixXd bound, MatrixXd rbound, unsigned int seed, const string log_name = "optbayes.log"):
	OptBase(dataset, func, bound, rbound, seed, log_name),
	sigma(3),
	init_nsample(dim * 10),
	relearn_nsample(dim * 10),
	nstart_point(10),
	nthread(0),
	msp_end_num(10),
	ls_end_num(5),
	hyp(VectorXd::Constant(0, 0)),
	max_update(200),
	min_lcb_diff(0.1),
	sp(MatrixXd::Constant(dim, nstart_point, 0)),
	spf(VectorXd::Constant(dim, 0)),
	crit(nstart_point, 0.0),
	is_init(nstart_point, true),
	is_imp(nstart_point, false),
	lcb_no_improve(nstart_point, 0),
	is_conv(nstart_point, false),
	nsp_wo_imp(0),
	n_trained_sample(0),
	region_max_nsample(0)
	{
		gp_bound.resize(dim, 2);
		gp_bound.col(0) = MatrixXd::Constant(dim, 1, 0);
		gp_bound.col(1) = MatrixXd::Constant(dim, 1, 1);
	};

	enum opt_bayes_case{
		empty = 0,
		onestep,
		complete,
		incomplete,
		fail
	};

	void initialize();
	void initialize(MatrixXd x, VectorXd f);
	void bayes_init();
	//opt_bayes_case optimize(MatrixXd& x, VectorXd& f);
	//opt_bayes_case optimize1();
	opt_bayes_case optimize();
	void train_gp(bool force_relearn = false);
	nlopt::opt set_optimizer(
			boost::shared_ptr<bayesopt::PosteriorModel> gp_t);
	void reset_gp_objective(nlopt::opt& nlopt_opt,
			boost::shared_ptr<bayesopt::PosteriorModel> gp_t);
	double tester(const vector<double>& x, void* data);
	VectorXd get_hyp();
	VectorXd get_hyp_ls();
	bool check_terminate(opt_bayes_case& optcase);
	void check_close();
	void monitor();
	void monitor_x();
	void set_param(Config& config);
};

#endif
