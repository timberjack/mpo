#include <iostream>
#include <Eigen/Dense>
#include <random>
#include "benchmark.hpp"
#include "config.hpp"
#include "optbayes.hpp"
#include "dataset.hpp"
#include <boost/shared_ptr.hpp>

using namespace std;
using namespace Eigen;

int main()
{
	cout << "designeasy-test" << endl;
	const string work_path = "de_demo";
	if(isexist(work_path))
	{
		removedir(work_path);
	}
	makedir(work_path);
	copyto("de_opt_setting.ini", work_path);
	copyto("de.ini", work_path);
	gotopath(work_path);

	Config config;
	config.read("de_opt_setting.ini");

	setDE(config.source, config.hspice, config.problem);

	int dim = config.dim;
	Func func = config.func;
	MatrixXd rbound = config.rbound;
	random_device rd;
	const int seed = rd();

	MatrixXd bound(dim, 2);
	bound.col(0) = MatrixXd::Constant(dim, 1, -1);
	bound.col(1) = MatrixXd::Constant(dim, 1, 1);
	boost::shared_ptr<Dataset> dataset(new Dataset(dim));
	OptBayes opt(dataset, func, bound, rbound, seed);
	opt.set_param(config);
	opt.set_stats();
	opt.initialize();
	opt.optimize();
	opt.solution();

	return 0;
};
