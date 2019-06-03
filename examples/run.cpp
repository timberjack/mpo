#include <iostream>
#include <boost/mpi/environment.hpp>
#include <boost/mpi/communicator.hpp>
#include <fstream>
#include <random>
#include "master1.hpp"
#include "slave1.hpp"
#include <cstdio>

using namespace std;
namespace mpi = boost::mpi;

#define DEBUG_RANK 1

int root = 0;

static void debugger(size_t rank)
{
	if((getenv("DEBUG") != NULL) && (rank == DEBUG_RANK))
	{
		volatile int i = 0;
		cerr << "pid " << (long)getpid() << endl;
		while(i == 0){};
	}
};

int main(int argc, char* argv[])
{
	mpi::environment env;
	mpi::communicator world;
	random_device rd;
	unsigned int rand_seed = rd();
	if(world.rank() == root)
	{
		//debugger(world.rank());
		Master1 mnode(world, rand_seed, "m");
		mnode.run();
	}
	else
	{
		debugger(world.rank());
		Slave1 snode(world, "slave", rand_seed, "p");
		snode.run();
	}
	return 0;
};
