#include <iostream>
#include <random>
#include "config.hpp"
#include "optbayes.hpp"
#include "benchmark.hpp"
#include <Eigen/Dense>
#include "dataset.hpp"
#include <boost/shared_ptr.hpp>

using namespace std;
using namespace Eigen;

int main()
{
	// acquire config
	cout << "math-test" << endl;
	const string work_path = "math_demo";
	if(isexist(work_path))
	{
		removedir(work_path);
	}
	makedir(work_path);
	copyto("math_opt_setting.ini", work_path);
	gotopath(work_path);

	Config config;
	config.read("math_opt_setting.ini");
	config.print();

	// acquire problem
	size_t dim = config.dim;
	Func func = config.func;
	MatrixXd rbound = config.rbound;

	// setup opt
	MatrixXd bound(dim, 2);
	bound.col(0) = MatrixXd::Constant(dim, 1, -1);
	bound.col(1) = MatrixXd::Constant(dim, 1, 1);
	
	random_device rd;
	const int seed = rd();
	MatrixXd mx;
	VectorXd my;
	boost::shared_ptr<Dataset> dataset(new Dataset(config.dim));
	OptBayes opt(dataset, func, bound, rbound, seed);
	opt.set_param(config);
	opt.set_stats();
	opt.initialize();
	opt.optimize();
	opt.solution();
	// show result
	//cout << "mx: " << mx << endl;
	//cout << "my: " << my << endl;*/
	
	// show f
	/*VectorXd x_test_1(2), x_test_2(2), x_test_3(2), x_test_4(2), x_test_5(2);
	x_test_1 << -3.142, 12.275;
	x_test_2 << 3.142, 2.275;
	x_test_3 << 9.425, 2.475;
	x_test_4 << 0, 0;
	x_test_5 << -5, 10;
	cout << "1: " << config.func(x_test_1) << endl;
	cout << "2: " << config.func(x_test_2) << endl;
	cout << "3: " << config.func(x_test_3) << endl;
	cout << "4: " << config.func(x_test_4) << endl;
	cout << "5: " << config.func(x_test_5) << endl;*/
	return 0;
}
