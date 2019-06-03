#include <iostream>
#include <fstream>
#include <random>
#include <boost/mpi/environment.hpp>
#include <boost/mpi/communicator.hpp>
#include "slave1.hpp"
using namespace std;
namespace mpi = boost::mpi;

int main(int argc, char* argv[])
{
	random_device rd;
	unsigned int rand_seed = rd();
	mpi::environment env;
	mpi::communicator world;
	Slave1 snode(world, "single", rand_seed, "s");
	snode.single_run(10);
	return 0;
};
