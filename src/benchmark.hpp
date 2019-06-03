#ifndef _BENCHMARK_
#define _BENCHMARK_

#include <Eigen/Dense>
#include <iostream>
#include <fstream>
#include <functional>
#include <string>
#include <unistd.h>
#include <map>
#include <cmath>
#include <boost/math/constants/constants.hpp>
#include "Initialization.hpp"
//#include "interface.hpp"
#include "utils.hpp"
#include <omp.h>
#include <cstdlib>
#include "deplugin.hpp"

using namespace Eigen;
using namespace std;

// i for multiple-thread index
typedef std::function<double(const VectorXd, int i)> Func;

Func get_func(const string problem, const string tool, const string source, size_t& dim, MatrixXd& bound);

void parseDesignEasy(const string source, size_t &dim, MatrixXd& bound);

double designeasy_port(const VectorXd& x, int i);

double branin(const VectorXd& x, int i);

/*MatrixXd math_grlee12(const MatrixXd& x, int nthread = 0);

MatrixXd math_langermann(const MatrixXd& x, int nthread = 0);

MatrixXd math_eggholder(const MatrixXd& x, int nthread = 0);*/

double sqr(double x);

MatrixXd unscale(const MatrixXd& x, const MatrixXd& bound);

MatrixXd rescale(const MatrixXd& x, const MatrixXd& bound);

void setDE(const string source, const string hspice, const string sp);



#endif
