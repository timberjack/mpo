#ifndef _SLAVE_1_
#define _SLAVE_1_

#include <iostream>
#include <random>
#include <string>
#include "node.hpp"
#include "utils.hpp"
#include "optbase.hpp"
#include "optbayes.hpp"

using namespace std;

class Slave1: public Node
{
private:
	mt19937_64 engine;
	int rank;
	int root;
	MatrixXd bound;
	boost::scoped_ptr<OptBase> opt_base;
	boost::scoped_ptr<OptBayes> opt_bayes;
	string work_path;
	pstatus status;
	unsigned int seed;
	const string mode;

public:
	Slave1(mpi::communicator& w, const string mode, unsigned int seed, 
			const string work_pathi)
	:Node(w, seed),
	engine(mt19937_64(seed)),
	rank(w.rank()),
	root(0),
	work_path(work_pathi),
	status(pstatus::stop),
	seed(seed),
	mode(mode)
	{
		if(mode == "slave")
		{
			work_path.append(to_string((int)rank));
			setup_slave_dir();
		}
		else if(mode == "single")
		{
			setup_single_dir();
		}
		set_log("slave.log");
	};

	/*Slave1(mpi::communicator& w, const string mode, unsigned int seed, 
			const string work_path = "s")
	:Node(w, seed, "single.log"),
	engine(mt19937_64(seed)),
	rank(w.rank()),
	root(0),
	work_path(work_path),
	status(pstatus::stop),
	seed(seed)
	{
		setup_single_dir(config_file);
		bound = get_default_bound();
	};*/

	// mpirun
	void run();
	
	// offline operation (single node)	
	void single_run(int ntrial);

	// work path setup
	void setup_single_dir();
	void setup_slave_dir();

	// high-level decision-making
	bool handler();

	// define optimization task
	void set_problem();
	void set_optbayes();

	// operations
	void do_squery();
	void do_srand();
	void do_strain();
	void do_init_optbayes();
	void do_optbayes();
	void do_wait();
	void do_stop();
	void clean();
};

#endif
