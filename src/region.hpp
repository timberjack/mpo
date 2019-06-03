#ifndef _REGION_
#define _REGION_

#include <iostream>
#include <Eigen/Dense>
#include <boost/shared_ptr.hpp>
#include <boost/enable_shared_from_this.hpp>
#include <vector>
#include <queue>
#include <cassert>
#include <stack>
#include "dataset.hpp"
#include "utils.hpp"

using namespace std;
using namespace Eigen;

class Region: public boost::enable_shared_from_this<Region>
{
public:
	enum status_t {idle, busy, complete};
private:
	status_t status;
	MatrixXd bound;
	vector<size_t> data_idx;
	boost::shared_ptr<Dataset> dataset;
	size_t dim;

	// hyperparameters: hyp_lengthscale
	VectorXd hyp;
	VectorXd hyp_ls;
public:
	boost::shared_ptr<Region> pregion;
	vector<boost::shared_ptr<Region>> cregions;

	Region(boost::shared_ptr<Dataset> dataseti, const MatrixXd boundi)
	:status(idle),
	bound(boundi),
	dim(boundi.rows()),
	pregion(nullptr),
	dataset(dataseti),
	hyp_ls(VectorXd::Constant(dim, 1))
	{};
	
	Region(boost::shared_ptr<Dataset> dataseti, size_t dimi)
	:status(idle),
	dim(dimi),
	pregion(nullptr),
	dataset(dataseti),
	hyp_ls(VectorXd::Constant(dim, 1))
	{
		bound.resize(dim, 2);
		bound.col(0) = MatrixXd::Constant(dim, 1, -1);
		bound.col(1) = MatrixXd::Constant(dim, 1, 1);
	};
	const MatrixXd get_bound();
	void add_data(const MatrixXd& newx, const VectorXd& newf);
	void get_data(vector<size_t> idx, MatrixXd& newx, VectorXd& newf);
	void get_data(size_t idx, VectorXd& newx, double& newf);
	void get_data(MatrixXd& newx, VectorXd& newf);
	double get_min_f();
	bool divide(int nc, const string div_option);
	void divide_data();
	void add_data_idx(vector<size_t> idx);
	void add_data_idx(size_t idx);
	boost::shared_ptr<Region> get_idle_region();
	void set_status(Region::status_t new_status);
	status_t get_status();
	unsigned int get_num_cregions();
	unsigned int get_num_data();
	boost::shared_ptr<Region> get_root();
	vector<boost::shared_ptr<Region>> get_leaf();
	/*void get_division(const MatrixXd& bound, vector<MatrixXd>& bound_d, 
		size_t start, size_t end, const string div_option);*/

	void get_division(const MatrixXd& bound, MatrixXd& bound_d, 
		size_t n, const VectorXd hyp_ls, const string div_option);
	void divide_step(const MatrixXd bound, MatrixXd& lb, MatrixXd& ub,
		size_t start, size_t end, VectorXd& hyp_list, const string option);
	size_t divide_dim_1(const MatrixXd bound_div);
	size_t divide_dim_2(VectorXd& hyp_list);
	size_t divide_dim_3(VectorXd& hyp_list);
	void set_hyp(VectorXd hypi);
	void set_hyp_ls(VectorXd hyp_lsi);
	VectorXd get_hyp();
	VectorXd get_hyp_ls();
	void test()
	{
		for(size_t i = 0; i < data_idx.size(); i++)
		{
			cout << "idx: " << data_idx[i] << endl;
		}
		cout << "dataset size: " << dataset->size() << endl;
	}
	void write_tree();
};

#endif
