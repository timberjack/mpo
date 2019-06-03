#ifndef _COMM_
#define _COMM_

#include <iostream>
#include <boost/mpi.hpp>
#include <string>
#include <fstream>
#include <Eigen/Dense>
#include <type_traits>
#include "eigen_serial.h"
#include "utils.hpp"

using namespace Eigen;
using namespace std;
namespace mpi = boost::mpi;

class Comm
{
private:
	int comm_verbose_level;

public:

	ofstream log;

	// message tags (s for send, r for receive, d for data, o for options, e for end)
	enum msg {
		// send
		squery = 0,
		srandom,
		sinitopt,
		sopt,
		swait,
		sstop,
		strain,
		soption,
		soptionend,
			
		// receive
		rquery,
		rrandom,
		ropt,
		rstop,
		rtrain,

		// data
		dbound,
		dx,
		df,
		dhyp,		// hyperparameters
		dhyp_ls, 	// hyparparameters lengthscale
		dgfmin,			// global fmin
		
		// options
		oproblem,
		otool,
		omethod,
		onumrandsample,
		omininitsample,
		oregionmaxnsample,
		osigma,
		olsendnum,
		omspendnum,
		ohyptype,
		omaxupdate,
		ominlcbdiff,
		onstartp,
		onthread,		

		// optimize case
		opt_onestep,
		opt_complete,
		opt_incomplete,
		opt_fail,

		// end
		eend,

		// empty
		empty 		// default
	};

	static const string explain_msg(int s)
	{
	#define C(A) case(A): return #A
		switch(s)
		{
			C(squery);
			C(srandom);
			C(sinitopt);
			C(sopt);
			C(swait);
			C(sstop);
			C(strain);
			C(soption);
			
			C(rquery);
			C(rrandom);
			C(ropt);
			C(rstop);
			C(rtrain);
			
			C(dbound);
			C(dx);
			C(df);
			C(dhyp);
			C(dhyp_ls);
			C(dgfmin);
			
			C(oproblem);
			C(otool);
			C(omethod);
			C(onumrandsample);
			C(omininitsample);
			C(oregionmaxnsample);
			C(osigma);
			C(olsendnum);
			C(omspendnum);
			C(ohyptype);
			C(omaxupdate);
			C(ominlcbdiff);
			C(onstartp);
			C(onthread);

			C(opt_onestep);
			C(opt_complete);
			C(opt_incomplete);
			C(opt_fail);

			C(eend);
			
			C(empty);
		
			default:
			    return "Unknown status";
	    	}
	#undef C
	};
	
	Comm()
	:comm_verbose_level(0)
	{};	

	Comm(const string log_name)
	:comm_verbose_level(0)
	{
		log.open(log_name.c_str());
	};

	~Comm()
	{
		log.close();
	}

	void print_msg(const string action, string msg)
	{
		log << "[" << action << "]" << "\t" << msg << endl; 
	};

	template<class T>
	void print_log(const string action, int tag, int dest, T value)
	{
		log << "[" << action << " " << explain_msg(tag) << "]" 
			<< "\t" << dest 
			<< "\t" << value << endl; 
	}

	template<class T = MatrixXd>
	void print_log (const string action, int tag, int dest, MatrixXd value)
	{
		log << "[" << action << " " << explain_msg(tag) << "]" 
			<< "\t" << dest 
			<< "\t" << value.rows() << "*" << value.cols() 
			<< " matrix" << endl;
		log << "test matrix: " << value << endl; 
	}

	void print_log_end()
	{
		log << "--------------------------------------------" << endl;
	};

	/* p to p send message with context send matrix and tag to dest */
	void msend(boost::mpi::communicator& world, int dest, int tag, int value)
	{
		world.send(dest, tag, value);
		log << "[send]\t" << "send " << explain_msg(tag) 
			<< " to node " << dest << ":\t" << value << "." << endl;
	}

	/* p to p send message with context send matrix and tag to dest */
	void msend(boost::mpi::communicator& world, int dest, int tag, double value)
	{
		world.send(dest, tag, value);
		log << "[send]\t" << "send " << explain_msg(tag) 
			<< " to node " << dest << ":\t" << value << "." << endl;
	}

	/* p to p send message with context send matrix and tag to dest */
	void msend(boost::mpi::communicator& world, int dest, int tag, string value)
	{
		world.send(dest, tag, value);
		log << "[send]\t" << "send " << explain_msg(tag) 
			<< " to node " << dest << ":\t" << value << "." << endl;
	}

	/* p to p send message with context send matrix and tag to dest */
	void msend(boost::mpi::communicator& world, int dest, int tag, MatrixXd value)
	{
		world.send(dest, tag, value);
		log << "[send]\t" << "send " << explain_msg(tag) 
			<< " to node " << dest << ":\t" 
			<< value.rows() << "*" << value.cols() << "." << endl;
	}

	/* p to p send message with context send matrix and tag to dest */
	void msend(boost::mpi::communicator& world, int dest, int tag, VectorXd value)
	{
		world.send(dest, tag, value);
		log << "[send]\t" << "send " << explain_msg(tag) 
			<< " to node " << dest << ":\t" 
			<< value.size() << "." << endl;
	}

	/* p-to-p receive message with context recv_matrix and tag from source */
	void mrecv(boost::mpi::communicator& world, int source, int tag, int& value)
	{
		world.recv(source, tag, value);
		log << "[recv]\t" << "receive " << explain_msg(tag) 
			<< " from node " << source << ":\t" << value << "." << endl;
	}

	/* p-to-p receive message with context recv_matrix and tag from source */
	void mrecv(boost::mpi::communicator& world, int source, int tag, double& value)
	{
		world.recv(source, tag, value);
		log << "[recv]\t" << "receive " << explain_msg(tag) 
			<< " from node " << source << ":\t" << value << "." << endl;
	}

	/* p-to-p receive message with context recv_matrix and tag from source */
	void mrecv(boost::mpi::communicator& world, int source, int tag, string& value)
	{
		world.recv(source, tag, value);
		log << "[recv]\t" << "receive " << explain_msg(tag) 
			<< " from node " << source << ":\t" << value << "." << endl;
	}

	/* p-to-p receive message with context recv_matrix and tag from source */
	void mrecv(boost::mpi::communicator& world, int source, int tag, MatrixXd& value)
	{
		world.recv(source, tag, value);
		log << "[recv]\t" << "receive " << explain_msg(tag) 
			<< " from node " << source << ":\t" 
			<< value.rows() << "*" << value.cols() << "." << endl;
	}

	/* p-to-p receive message with context recv_matrix and tag from source */
	void mrecv(boost::mpi::communicator& world, int source, int tag, VectorXd& value)
	{
		world.recv(source, tag, value);
		log << "[recv]\t" << "receive " << explain_msg(tag) 
			<< " from node " << source << ":\t" 
			<< value.size() << "." << endl;
	}

	void set_log(const string filename)
	{
		log.open(filename.c_str());
	};

	void set_verbose(int verbose)
	{
		comm_verbose_level = verbose;
	}
};

#endif
