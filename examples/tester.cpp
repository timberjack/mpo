#include <iostream>
#include <Eigen/Dense>
#include <random>
#include <boost/mpi/environment.hpp>
#include <boost/mpi/communicator.hpp>
#include "region.hpp"
#include "dataset.hpp"
#include <boost/shared_ptr.hpp>
using namespace std;
using namespace Eigen;

int main()
{
	boost::shared_ptr<Dataset> dataset(new Dataset(2));
	MatrixXd bound(2, 2);
	bound.col(0) = MatrixXd::Constant(2, 1, -1);
	bound.col(1) = MatrixXd::Constant(2, 1, 1);
	boost::shared_ptr<Region> root(new Region(dataset, bound));
	
	// test1 add_data
	MatrixXd x1(2, 2);
	x1.col(0) << 0, 1;
	x1.col(1) << 1, 0;
	VectorXd f1(2);
	f1(0) = 3;
	f1(1) = 4;	
	root->add_data(x1, f1);
	root->test();
	root->divide(2, "max_blength");

	{
		cout << "------------------" << endl;
		cout << "test13" << endl;
		
		root->cregions[0]->divide(3, "max_blength");
		root->cregions[0]->cregions[1]->divide(4, "max_blength");
		root->write_tree();
	}
	 
}
