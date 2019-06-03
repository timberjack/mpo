#ifndef _MASTER_1_
#define _MASTER_1_

#include <iostream>
#include <vector>
#include <queue>
#include <map>
#include <boost/mpi/communicator.hpp>
#include <boost/mpi.hpp>
#include <boost/shared_ptr.hpp>
#include <string>
#include "node.hpp"
#include "region.hpp"
#include "utils.hpp"
#include "unistd.h"
#include "benchmark.hpp"
#include <algorithm>

class Master1: public Node
{
private:
	boost::shared_ptr<Region> oregion;
	std::map<int, pstatus> ps;
	std::map<int, boost::shared_ptr<Region> > rs;
	std::queue<int> wq;
	unsigned int nslave;
	int root;
	std::string work_path;
public:
	Master1(boost::mpi::communicator& w, unsigned int seed, 
			const std::string work_path = "n")
	:Node(w, seed),
	nslave(w.size() - 1),
	root(0),
	work_path("m")
	{
		setup_master_dir();
		set_log("master.log");
		oconfig.read("setting.ini");
		adjust();
		odataset->reset_data(oconfig.dim);
		oregion.reset(new Region(odataset, oconfig.dim));

		// init status tables
		init_flags();

		// init file
		//std::string ostats_file = oconfig.tool + "_" + oconfig.problem
		//	 + "_stats.log";
		ostats.set_log("stats.log");
		if(oconfig.tool == "designeasy")
		{
			setDE(oconfig.source, oconfig.hspice, oconfig.problem);
		}
		print_log_end();
	};

	// mpirun
	void run();
	void nrun(int ntrial);

	// work path setup
	void setup_master_dir();
	void init_flags();

	// top-level decision-making
	void handler();

	// initial steps
	void init_query();
	void init_random_sample();
	void init_divide();
	void init_train();

	// communication
	void send_query(int slave_rank);
	void send_random_sample(int slave_rank, int nrandom_sample);
	void send_init_opt(int slave_rank, boost::shared_ptr<Region> r);
	void send_opt(int slave_rank);
	void send_wait(int slave_rank);
	void send_stop(int slave_rank);

	// operations
	void do_rquery(int slave_rank, int reply);
	void do_rrandom(int slave_rank);
	void do_rtrain(int slave_rank);
	void do_ropt(int slave_rank);
	void do_ropt_terminate(int slave_rank);
	void do_ropt_onestep(int slave_rank);
	void do_ropt_complete(int slave_rank);
	void do_ropt_incomplete(int slave_rank);
	void do_ropt_fail(int slave_rank);
	void do_stop();
	void do_queue(bool is_terminate);

	// termination check
	bool check_terminate();

	// region handle
	boost::shared_ptr<Region> release_region(int slave_rank);
	void assign_region(int slave_rank, boost::shared_ptr<Region> r);
	boost::shared_ptr<Region> release_region_dup(int slave_rank);
	void assign_region_dup(int slave_rank, boost::shared_ptr<Region> r);

	// based on limits, modified options
	void adjust();

	void test();

	bool check_live();
	void write_rtree();
	void write_solution();
	void clean();
};

#endif
