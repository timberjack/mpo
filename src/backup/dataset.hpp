#ifndef _DATASET_
#define _DATASET_

#include <Eigen/Dense>
#include <iostream>
#include <map>
#include <utility>
#include <vector>
#include <utility>
#include "utils.hpp"

#define MAX_STORAGE 1e8

using namespace std;
using namespace Eigen;

class Dataset
{
	map<unsigned int, pair<VectorXd, double> > mdata;
	size_t dim;
	unsigned long int min_idx;
	unsigned long int next_idx;		// existing max key
public:
	Dataset(size_t dimi):dim(dimi);
	void clear();
	const unsigned long int Dataset::add_data(const VectorXd& newx, const double& newf);
	const vector<unsigned int> add_data(const MatrixXd& newx, const MatrixXd& newf);

	void get_data(unsigned int idx, VectorXd& newx, double& newf);	
	VectorXd& get_data_x(unsigned int idx);
	double& get_data_f(unsigned int idx);

	void get_batch(unsigned int idx, MatrixXd& newx, VectorXd& newf);
	MatrixXd& get_batch_x(unsigned int idx);
	VectorXd& get_batch_f(unsigned int idx);
	
	bool get_min(VectorXd& newx, double& newf);
	double get_min_f();
	unsigned int size();
	static bool better(const double& f1, const double& f2);
	unsigned long int find_void_key();
};

#endif
