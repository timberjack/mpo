#ifndef _OPTBASE_
#define _OPTBASE_

#include <iostream>
#include <chrono>
#include <fstream>
#include <Eigen/Dense>
#include <string>
#include <random>
#include <functional>
#include "benchmark.hpp"
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/io.hpp>
#include <boost/shared_ptr.hpp>
#include <omp.h>
#include <vector>
#include "utils.hpp"
#include "stats.hpp"
#include "dataset.hpp"
#include <iomanip>
#include "utils.hpp"
#include <algorithm>

#define INF std::numeric_limits<double>::infinity()

typedef boost::numeric::ublas::vector<double>  vectord;
typedef boost::numeric::ublas::matrix<double>  matrixd;
typedef std::function<VectorXd(const MatrixXd)> BatchFunc;

using namespace std;
using namespace Eigen;
using namespace std::chrono;

class OptBase
{
protected:
	//MatrixXd unscale(const MatrixXd& x); 	// map from opt domain to user-define domain
	//MatrixXd rescale(const MatrixXd& x);	// map from user-define domain to opt domain

	BatchFunc batch_func;				// openmp parallel target function
	BatchFunc run_func;				// opt modified target function
	Func func;				// target function
	double ref_best_f;			// overall optimal f for reference
	unsigned int seed;			// seed record
	mt19937_64 engine;			// random seed
	MatrixXd bound;				// domain lower & upper bounds				
	MatrixXd rbound;			// real bounds, refer to lower & upper bounds
	size_t dim;				// dimension
	double scaled_lb, scaled_ub;		// scaled lower & upper bounds
	std::ofstream log;			// log

	// data
	//Dataset odataset;
	boost::shared_ptr<Dataset> odataset;
	vector<size_t> last;

	// multiple-process lock
	omp_lock_t updatelock;

	// measure
	Stats ostats;
	bool ostats_on;

public:		// optimization case
	OptBase(boost::shared_ptr<Dataset> dataset, Func funci, MatrixXd boundi, MatrixXd rboundi, unsigned int seedi, const string log_name = "opt.log")
	:scaled_lb(-1),
	scaled_ub(1),
	func(funci),
	ref_best_f(INF),
	seed(seedi),
	engine(seedi),
	bound(boundi),
	rbound(rboundi),
	dim(boundi.rows()),
	odataset(dataset),
	ostats_on(false)
	{
		if(isexist(log_name))
		{
			removefile(log_name);
		}
		log.open(log_name.c_str(), ofstream::app);
		log.exceptions(log.failbit | log.badbit);

		// mp lock init
		omp_init_lock(&updatelock);

		// normalized inputs
		batch_func = [&](const MatrixXd x, int nthread = 0)->VectorXd
		{
			int num_thread;
			if(nthread > 0)
			{				
				num_thread = nthread;
			}
			else
			{
				num_thread = omp_get_max_threads();
			}

			VectorXd bf(x.cols());
			#pragma omp parallel for num_threads(num_thread)
			for(size_t i = 0; i < x.cols(); i++)
			{
				double f = func(move(rescale(rescale(x.col(i), bound), rbound)), omp_get_thread_num());
				bf(i) = f;
			}
			return bf;
		};
	
		// take normal input
		run_func = [&](const MatrixXd x)->VectorXd
		{
			const auto t1 = high_resolution_clock::now();
			MatrixXd xm = outofbound_check(x);
			const VectorXd f = batch_func(xm);
			log << "[opt]\t" << "evaluate " << xm.cols() << " samples." << endl;
			
			//#pragma omp single
			omp_set_lock(&updatelock);
			add_sample(xm, f);
			if(get_best_f() < ref_best_f)
			{
				ref_best_f = odataset->get_min_f();
				log << "[opt]\t" << "ref_best_f updates to "
						<< ref_best_f << endl; 
			}
			const auto t2 = high_resolution_clock::now();
			const double t_eval = duration_cast<milliseconds>(t2 - t1).count();
		 	log << "[opt]\t" << "evaluation time: " << (t_eval/1000) << " s" << endl;
			if(ostats_on)
			{
				ostats.write_log(get_best_f(), get_size());
			}
			omp_unset_lock(&updatelock);

			return f;
		};
		//log << "optimizer created." << endl;
	};

	~OptBase()
	{
		omp_destroy_lock(&updatelock);	
		if(log.good())
		{
			log.close();
		}
	};

	// format transform
	static MatrixXd vec_eig_to_eig_m(const vector<VectorXd> v);
	static matrixd eig_to_ublas_m(const MatrixXd m);
	static vectord eig_to_ublas_v(const VectorXd v);
	static MatrixXd ublas_to_eig_m_v(vector<vectord> v);
	static MatrixXd ublas_to_eig_m(matrixd m);
	static VectorXd ublas_to_eig_v(vectord v);
	static vector<double> eig_to_vec_v(VectorXd v);
	static VectorXd vec_to_eig_v(vector<double> v);

	// Euclidean distance compute
	static MatrixXd sdist_mm(const MatrixXd X, const MatrixXd Y);
	static double sdist_vv(const VectorXd v1, const VectorXd v2);
	static VectorXd sdist_vm(const VectorXd v, const MatrixXd m);

	// get random matrix
	MatrixXd get_rand_matrix(size_t num);
	MatrixXd rand_matrix(size_t num, const Eigen::VectorXd& lb, const Eigen::VectorXd& ub,
				mt19937_64& eig);
	bool better(const double f1, const double f2);
	void find_best(const MatrixXd xs, const VectorXd fs, VectorXd& best_x, 
			double& best_f);

	// rescale, support for user-defined domain
	MatrixXd unscale(const MatrixXd& x, const MatrixXd& boundi); 	// map from opt domain to user-define domain
	MatrixXd rescale(const MatrixXd& x, const MatrixXd& boundi);	// map from user-define domain to opt domain
	void rand_sample(unsigned int num, MatrixXd& optx, VectorXd& optf);
	void add_sample(const MatrixXd& x, const VectorXd& f);
	void add_sample_old(const MatrixXd& x, const VectorXd& f);
	MatrixXd get_x();
	VectorXd get_f();
	void move_new_sample(MatrixXd& x, VectorXd& f);
	size_t get_n_new_sample();
	VectorXd get_best_x();
	double get_best_f();
	double get_ref_best_f();
	size_t get_size();
	void set_ref_best_f(double value);
	MatrixXd outofbound_check(MatrixXd x);
	const string set_stats(bool is_on = true)
	{
		ostats_on = is_on;
		return (ostats.set_auto_log());
	};
	void solution();
};

#endif
