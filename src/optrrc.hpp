#ifndef _OPTRRC_
#define _OPTRRC_

#include <iostream>
#include "optbase.hpp"
#include <nlopt.hpp>
#include <boost/shared_ptr.hpp>
#include <Eigen/Dense>
#include <vector>

using namespace std;

class OptRRC: public OptBase
{
public:
	unsigned int nthread;
	unsigned int nstart_point;
	unsigned int max_update;

	enum opt_rrc_case{
		empty = 0;
		onestep,
		complete,
		incomplete,
		fail
	};

	MatrixXd sp;
	VectorXd spf;
	vector<bool> is_init;

	OptRRC(boost::shared_ptr<>)
	void optimize(boost::shared_ptr<Dataset> dataset, Func func, MatrixXd bound,
		MatrixXd rbound, unsigned int seed, const string log_name = "optrrc.log")
	:nthread(0),
	nstart_point(10),
	max_update(0),
	sp(MatrixXd::Constant(dim, nstart_point, 0)),
	spf(VectorXd::Constant(nstart_point, 0)),
	is_init(nstart_point, true)
	{
	};
};

#endif
