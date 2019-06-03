#ifndef _NODE_
#define _NODE_

#include <iostream>
#include <boost/mpi.hpp>
#include <boost/scoped_ptr.hpp>
#include <boost/shared_ptr.hpp>
#include <string>
#include <random>
#include <Eigen/Dense>
#include "comm.hpp"
#include "dataset.hpp"
#include "stats.hpp"
#include "config.hpp"

namespace mpi = boost::mpi;
using namespace Eigen;

class Node: public Comm
{
protected:
	boost::mpi::communicator world;
	Stats ostats;
	Config oconfig;
	boost::shared_ptr<Dataset> odataset;
	mt19937_64 engine;

public:
	enum pstatus
	{
		running = 0,
		queue,
		hang,
		stop
	};

	Node(boost::mpi::communicator& w, unsigned int seed)
	:Comm(),
	ostats(),
	world(w),
	engine(mt19937_64(seed))
	{
		odataset.reset(new Dataset());
	};
	
	void reset_data(size_t dim);
	boost::shared_ptr<Dataset> get_dataset();
	void add_data(const MatrixXd& x, const VectorXd& f);
	void add_data(const VectorXd& x, const double& f);
	void add_gmin_f(double gmin_f);
	MatrixXd get_x();
	VectorXd get_f();
	VectorXd get_min_x();
	double get_min_f();
	size_t get_nsample();
	void clear_data();
	MatrixXd get_default_bound(size_t dim);
	void print_progress();
	void write_log();
};

#endif
