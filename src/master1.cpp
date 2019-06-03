#include "master1.hpp"

void Master1::run()
{
	init_query();
	if(wq.empty())
	{
		exit(0);
	}
	init_random_sample();
	//init_train();
	init_divide();

	// runtime until termination condition met
	while((!check_terminate()) || (check_live()))
	{
		// decision-making
		handler();

		// write tree
		write_rtree();

		// write result
		//ostats.write_log(get_min_f(), get_nsample());
		write_log();

		// print progress
		print_progress();
	}
	// send stop
	do_stop();

	// write solution
	write_solution();
};

void Master1::nrun(int ntrial)
{
	makedir("experiment");
	init_query();
	if(wq.empty())
	{
		exit(0);
	}
	for(size_t i = 0; i < ntrial; i++)
	{
		init_random_sample();
		//init_train();
		init_divide();

		// runtime until termination condition met
		while((!check_terminate()) || (check_live()))
		{
			// decision-making
			handler();

			// write tree
			write_rtree();

			// write result
			write_log();

			// print progress
			print_progress();
		}
		write_solution();
		copyto("stats.log", "experiment/stats" + to_string(i) + ".log");
		copyto("rtree.log", "experiment/rtree" + to_string(i) + ".log");
		removefile("stats.log");
		removefile("rtree.log");
		clean();
	}
	do_stop();
};

void Master1::setup_master_dir()
{
	/* check if master folder exists */
	/* if so, cancel the running instance */
	if(isexist(work_path))
	{
		removedir(work_path);
	}

	/* create master folslaveder */
	std::string cmd = "mkdir -p " + work_path;
	int n = system(cmd.c_str());
	
	/* copy config file into master folder */
	copyto("setting.ini", work_path);

	/* copy problem list into master folder */
	copyto("de.ini", work_path);

	/* define master folder as work path */
	n = chdir(work_path.c_str());
};

void Master1::init_flags()
{
	// init status tables
	for(size_t i = 0; i < world.size(); i++)
	{
		if(i == root)
		{
			continue;
		}
		ps[i] = pstatus::hang;
		rs[i] = nullptr;
	}
};

void Master1::handler()
{
	bool is_recv = true;
	bool is_x = false, is_f = false;
	int rank;
	VectorXd hyp;
	VectorXd hyp_ls;
	MatrixXd mx;
	VectorXd mf;
	int n;
	int reply = 0;
	msg nextmove = empty;
	msg opt_case = empty;
	mpi::status msg_status = world.probe();
	rank = msg_status.source();

	while(is_recv)
	{
		mpi::status msg_status = world.probe(rank, mpi::any_tag);
		switch(msg_status.tag())
		{
			case msg::rquery:
				mrecv(world, rank, msg_status.tag(), reply);
				nextmove = rquery;
				is_recv = false;
				break;
			case msg::rrandom:
				mrecv(world, rank, msg_status.tag(), n);
				nextmove = rrandom;
				break;
			case msg::rtrain:
				mrecv(world, rank, msg_status.tag(), n);
				nextmove = rtrain;
				break;
			case msg::ropt:
				mrecv(world, rank, msg_status.tag(), n);
				nextmove = ropt;
				break;
			case msg::rstop:
				mrecv(world, rank, msg_status.tag(), n);
				nextmove = rstop;
				break;
			case msg::dx:
				mrecv(world, rank, msg_status.tag(), mx);
				//mx = m;
				is_x = true;
				break;
			case msg::df:
				mrecv(world, rank, msg_status.tag(), mf);
				is_f = true;
				if((is_x) && (is_f))
				{
					rs[rank]->add_data(mx, mf);
					is_x = false;
					is_f = false;
				}
				break;
			case msg::dhyp:
				mrecv(world, rank, msg_status.tag(), hyp);
				//hyp = m.col(0);
				//rs[rank]->set_hyp_ls(hyp);
				break;
			case msg::dhyp_ls:
				mrecv(world, rank, msg_status.tag(), hyp_ls);
				rs[rank]->set_hyp_ls(hyp_ls);
				break;
			case msg::opt_onestep:
				mrecv(world, rank, msg_status.tag(), n);
				opt_case = opt_onestep;
				break;
			case msg::opt_complete:
				mrecv(world, rank, msg_status.tag(), n);
				opt_case = opt_complete;
				break;
			case msg::opt_incomplete:
				mrecv(world, rank, msg_status.tag(), n);
				opt_case = opt_incomplete;
				break;
			case msg::opt_fail:
				mrecv(world, rank, msg_status.tag(), n);
				opt_case = opt_fail;
				break;
			case msg::eend:
				mrecv(world, rank, msg_status.tag(), n);
				is_recv = false;
				break;
			default:
				cerr << "[error] " << "invalid tag " 
					<< explain_msg(msg_status.tag()) << endl;
				exit(1);
		}
	}
	print_log_end();

	// handle to replies
	if(nextmove == rquery)
	{
		do_rquery(rank, reply);
	}
	else if(nextmove == rrandom)
	{
		do_rrandom(rank);
	}
	else if(nextmove == rtrain)
	{
		do_rtrain(rank);
	}
	else if(nextmove == ropt)
	{
		bool is_terminate = check_terminate();
		if(is_terminate)
		{
			do_ropt_terminate(rank);
		}
		else if(opt_case == opt_onestep)
		{
			do_ropt_onestep(rank);
		}
		else if(opt_case == opt_complete)
		{
			do_ropt_complete(rank);
		}
		else if(opt_case == opt_incomplete)
		{
			do_ropt_incomplete(rank);
		}
		else if(opt_case == opt_fail)
		{
			do_ropt_fail(rank);
		}
		do_queue(is_terminate);
	}
};

void Master1::init_query()
{
	int sd;
	sd = 1;
	for(size_t i = 0; i < world.size(); i++)
	{
		if(i == root)
		{
			continue;
		}

		send_query(i);
		handler();
	}
};

void Master1::init_random_sample()
{
	// send random sample
	int active_nslave = wq.size();
	check_invalid({active_nslave == 0}, 
			"init_random_sample", "no slave available");
	int init_per_world = ceil(oconfig.num_random_sample / active_nslave);
	int num_random_sample = oconfig.num_random_sample;
	if(oconfig.num_random_sample % active_nslave)
	{
		init_per_world++;
		oconfig.num_random_sample = init_per_world * active_nslave;
	}

	// send random sample message
	while(!wq.empty())
	{
		size_t slave_rank = wq.front();
		wq.pop();
		assign_region_dup(slave_rank, oregion);
		ps[slave_rank] = pstatus::running;
		send_random_sample(slave_rank, init_per_world);
		print_log_end();
	}

	// receive replies from slaves for random samples
	unsigned int random_sample_count = 0;
	while(random_sample_count < active_nslave)
	{
		handler();
		random_sample_count++;
	}
};

void Master1::init_train()
{
	int slave_rank = wq.front();
	wq.pop();
	assign_region(slave_rank, oregion);
	ps[slave_rank] = running;

	msend(world, slave_rank, msg::strain, 1);
	msend(world, slave_rank, msg::ohyptype, oconfig.hyptype);
	msend(world, slave_rank, msg::dbound, rs[slave_rank]->get_bound());
	MatrixXd mx;
	VectorXd mf;
	rs[slave_rank]->get_data(mx, mf);
	msend(world, slave_rank, msg::dx, mx);
	msend(world, slave_rank, msg::df, mf);
	msend(world, slave_rank, msg::eend, 1);
	print_log_end();
	handler();
};

void Master1::init_divide()
{
	// divide domain into num_init_divide regions
	// div defines dividiing method
	oregion->divide(oconfig.num_init_divide, oconfig.div);
	while(!wq.empty())
	{
			int slave_rank = wq.front();
			boost::shared_ptr<Region> r = oregion->get_idle_region();
			if(!r)
			{
				break;
			}
			wq.pop();
			ps[slave_rank] = running;
			check_invalid({rs[slave_rank].get()}, "init_divide", 
					"region assigned.");
			send_init_opt(slave_rank, r);
			print_log_end();
	}
};

/* send query to check availability of nodes */
void Master1::send_query(int slave_rank)
{
	msend(world, slave_rank, msg::squery, 1);
};

void Master1::send_random_sample(int slave_rank, int nrandom_sample)
{
	msend(world, slave_rank, msg::srandom, 1);
	msend(world, slave_rank, msg::oproblem, oconfig.problem);
	msend(world, slave_rank, msg::otool, oconfig.tool);
	msend(world, slave_rank, msg::onumrandsample, nrandom_sample);
	msend(world, slave_rank, msg::dbound, oregion->get_bound());
	msend(world, slave_rank, msg::eend, 1);
	ps[slave_rank] = pstatus::running;
};

void Master1::send_init_opt(int slave_rank, boost::shared_ptr<Region> r)
{
	assign_region(slave_rank, r);
	ps[slave_rank] = pstatus::running;
	msend(world, slave_rank, msg::sinitopt, 1);
	msend(world, slave_rank, msg::oproblem, oconfig.problem);
	msend(world, slave_rank, msg::omethod, oconfig.method);
	msend(world, slave_rank, msg::omininitsample, oconfig.min_init_sample);
	msend(world, slave_rank, msg::oregionmaxnsample, oconfig.region_max_nsample);
	msend(world, slave_rank, msg::osigma, oconfig.sigma);
	msend(world, slave_rank, msg::olsendnum, oconfig.ls_end_num);
	msend(world, slave_rank, msg::omspendnum, oconfig.msp_end_num);
	msend(world, slave_rank, msg::omaxupdate, oconfig.max_update);
	msend(world, slave_rank, msg::ominlcbdiff, oconfig.min_lcb_diff);
	msend(world, slave_rank, msg::onstartp, oconfig.nstart_point);
	msend(world, slave_rank, msg::onthread, oconfig.nthread);
	msend(world, slave_rank, msg::dbound, rs[slave_rank]->get_bound());
	if(rs[slave_rank]->get_num_data() > 0)
	{
		MatrixXd mx;
		VectorXd mf;
		rs[slave_rank]->get_data(mx, mf);
		msend(world, slave_rank, msg::dx, mx);
		msend(world, slave_rank, msg::df, mf);
	}
	if(get_nsample())
	{
		msend(world, slave_rank, msg::dgfmin, get_min_f());
	}
	msend(world, slave_rank, msg::eend, 1);
};

void Master1::send_opt(int slave_rank)
{
	msend(world, slave_rank, msg::sopt, 1);
	double gfmin = 0.0;
	if(get_nsample())
	{
		msend(world, slave_rank, msg::dgfmin, get_min_f());
	}
	msend(world, slave_rank, msg::eend, 1);
};

void Master1::send_wait(int slave_rank)
{
	release_region(slave_rank);
	ps[slave_rank] = pstatus::hang;
	wq.push(slave_rank);
	msend(world, slave_rank, msg::swait, 1);
	msend(world, slave_rank, msg::eend, 1);
};

void Master1::send_stop(int slave_rank)
{
	release_region(slave_rank);
	ps[slave_rank] = pstatus::stop;
	msend(world, slave_rank, msg::sstop, 1);
	msend(world, slave_rank, msg::eend, 1);
};

void Master1::do_rquery(int slave_rank, int reply)
{
	if(reply == 1)
	{
		if(ps[slave_rank] == pstatus::hang)
		{
			ps[slave_rank] = pstatus::queue;
			wq.push(slave_rank);
			int a = wq.size();
		}
	}
	else
	{
		ps[slave_rank] = pstatus::hang;
	}
};

// when receive replies about srandom, push this node into waiting queue
// release the region
void Master1::do_rrandom(int slave_rank)
{
	ps[slave_rank] = pstatus::queue;
	wq.push(slave_rank);
	release_region_dup(slave_rank);
};

void Master1::do_rtrain(int slave_rank)
{
	ps[slave_rank] = pstatus::queue;
	wq.push(slave_rank);
	release_region(slave_rank);
};

void Master1::do_ropt_terminate(int slave_rank)
{
	//send_stop(slave_rank);
	send_wait(slave_rank);
};

void Master1::do_ropt_onestep(int slave_rank)
{

	if((oconfig.strategy == "nondivide")||(oconfig.strategy == "static_divide"))
	{
		send_opt(slave_rank);
	}
	else if(oconfig.strategy == "dynamic_divide")
	{
		if(!wq.empty())
		{
			unsigned int nwait = wq.size();
			unsigned int ndivide = nwait + 1;
			bool is_divide = rs[slave_rank]->divide(ndivide, oconfig.div);
			if(is_divide)
			{
				boost::shared_ptr<Region> prev_r = release_region(slave_rank);
				boost::shared_ptr<Region> curr_r = prev_r->get_idle_region();
				send_init_opt(slave_rank, curr_r);
			}
			else
			{
				send_opt(slave_rank);
			}
		}
		else
		{
			send_opt(slave_rank);
		}	
	}
	print_log_end();
};

void Master1::do_ropt_complete(int slave_rank)
{
	rs[slave_rank]->set_status(Region::status_t::complete);
	if(oconfig.strategy == "nondivide")
	{
		send_stop(slave_rank);
	}
	else if((oconfig.strategy == "static_divide") || (oconfig.strategy == "dynamic_divide"))
	{
		release_region(slave_rank);
		boost::shared_ptr<Region> r = oregion->get_idle_region();
		if(r)
		{
			send_init_opt(slave_rank, r);
		}
		else
		{
			send_wait(slave_rank);
		}
	}
	print_log_end();
};

void Master1::do_ropt_incomplete(int slave_rank)
{
	if((oconfig.strategy == "nondivide") || (oconfig.strategy == "static_divide"))
	{
		send_opt(slave_rank);
	}
	else if(oconfig.strategy == "dynamic_divide")
	{	
		unsigned int nwait = (size_t)wq.size();
		unsigned int ndivide = max((int)(nwait + 1), 2);
		bool is_divide = rs[slave_rank]->divide(ndivide, oconfig.div);
		if(is_divide)
		{
			boost::shared_ptr<Region> prev_r = release_region(slave_rank);
			//boost::shared_ptr<Region> curr_r = prev_r->get_idle_region();
			boost::shared_ptr<Region> curr_r = oregion->get_idle_region();
			send_init_opt(slave_rank, curr_r);
		}
		else
		{
			send_opt(slave_rank);
		}
	}
	print_log_end();
};

void Master1::do_ropt_fail(int slave_rank)
{
	send_stop(slave_rank);
};

void Master1::do_stop()
{
	while(!wq.empty())
	{
		unsigned int slave_rank = wq.front();
		check_invalid({ps[slave_rank] != pstatus::hang}, 
				"do_stop", "incorrect status.");
		wq.pop();
		send_stop(slave_rank);
		print_log_end();
	}
};

void Master1::do_queue(bool is_terminate)
{
	boost::shared_ptr<Region> idle_r;
	if(is_terminate)
	{
		//do_stop();
	}
	else
	{
		while((!wq.empty()) && (idle_r = oregion->get_idle_region()))
		{
			unsigned int slave_rank = wq.front();
			wq.pop();
			send_init_opt(slave_rank, idle_r);
			print_log_end();
		}
	}
};

bool Master1::check_terminate()
{
	bool is_end = false;
	double t_duration = ostats.get_elapsed_time();
	if(	(oregion->get_status() == Region::complete)
		||((oconfig.max_eval != 0) && (get_nsample() >= oconfig.max_eval))
		||((oconfig.max_duration != 0) && (t_duration >= oconfig.max_duration)))
	{
		is_end = true;
		log << "[terminate]\t" << "region complete: " 
			<< (oregion->get_status() == Region::complete) << endl;
		log << "[terminate]\t" << "evaluation: " << get_nsample() << "/" << oconfig.max_eval 
			<< endl;
		log << "[terminate]\t" << "duration: " << t_duration << "/" << oconfig.max_duration 
			<< endl;
		log << "[terminate]\t" << is_end << endl;
		print_log_end();
	}
	else
	{
		is_end = false;
	}
	return is_end;
};

boost::shared_ptr<Region> Master1::release_region(int slave_rank)
{
	boost::shared_ptr<Region> r;
	//check_invalid({!rs[slave_rank].get()}, "release_region", "do not have an assigned region.");
	if(rs[slave_rank].get())
	{
		if(rs[slave_rank]->get_status() != Region::complete)
		{
			rs[slave_rank]->set_status(Region::idle);
		}
		r = rs[slave_rank];
	}
	else
	{
		r = nullptr;
	}
	rs[slave_rank] = nullptr;
	return r;
};

void Master1::assign_region(int slave_rank, boost::shared_ptr<Region> r)
{
	check_invalid({rs[slave_rank].get()}, "assign_region", "already has assigned region.");
	rs[slave_rank] = r;
	rs[slave_rank]->set_status(Region::busy);
};

/* duplicate: allow the same region assigned to different nodes */
boost::shared_ptr<Region> Master1::release_region_dup(int slave_rank)
{
	boost::shared_ptr<Region> r;
	//check_invalid({!rs[slave_rank]}, "release_region", "do not have an assigned region.");
	if(rs[slave_rank].get())
	{		
		r = rs[slave_rank];
	}
	else
	{
		r = nullptr;
	}
	rs[slave_rank] = nullptr;
	return r;
};

void Master1::assign_region_dup(int slave_rank, boost::shared_ptr<Region> r)
{
	check_invalid({rs[slave_rank].get()}, "assign_region", "already has assigned region.");
	rs[slave_rank] = r;
};

void Master1::adjust()
{
	if(oconfig.num_init_divide == 0)
	{
		oconfig.num_init_divide = nslave;
		log << "[adjust]\t" << "adjust num_init_divide to " << nslave << "."
			<< endl;
	}
};


bool Master1::check_live()
{
	bool is_live = false;
	for(std::map<int, pstatus>::iterator it = ps.begin(); 
		it != ps.end(); it++)
	{
		if((it->second == pstatus::running)||(it->second == pstatus::queue))
		{
			is_live = true;
		}
	}
	return is_live;
};

void Master1::write_rtree()
{
	oregion->write_tree();
};

void Master1::write_solution()
{
	odataset->solution(oconfig.rbound);
};

void Master1::clean()
{
	odataset->reset_data(oconfig.dim);
	oregion.reset(new Region(odataset, oconfig.dim));
	ostats.write_new_log("stats.log");
	
};
