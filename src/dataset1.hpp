#ifndef _DATASET_
#define _DATASET_

#include <Eigen/Dense>
#include <iostream>
#include <fstream>
#include <map>
#include <utility>
#include <vector>
#include <utility>
#include <iomanip>
#include "utils.hpp"

#define STORAGE 1000
#define INF std::numeric_limits<double>::infinity()

using namespace std;
using namespace Eigen;

class Dataset
{
	MatrixXd mx;
	VectorXd mf;
	size_t dim;
	size_t min_idx;
	double gmin_f;
	size_t msize;
	int sizeorder;

public:
	Dataset(size_t dim)
	:min_idx(0),
	dim(dim),
	mx(MatrixXd::Constant(dim, STORAGE, 0)),
	mf(VectorXd::Constant(STORAGE, 0)),
	gmin_f(INF),
	msize(0),
	sizeorder()
	{};

	~Dataset()
	{
		cout << "Dataset des." << endl;
	};
	
	void clear();
	vector<size_t> add_data(const MatrixXd& x, const VectorXd& f);
	void add_gmin_f(double gmin_f);
	size_t add_data(const VectorXd& x, const double& f);
	void get_data(const vector<size_t>& idx, MatrixXd& x, VectorXd& f);
	void get_data(const size_t& idx, VectorXd& x, double& f);
	MatrixXd get_x();
	VectorXd get_f();
	VectorXd get_min_x();
	double get_min_f();
	double get_gmin_f();
	bool is_empty();
	size_t updatemin(const VectorXd& f);
	size_t size();
	void print();
};

#endif
