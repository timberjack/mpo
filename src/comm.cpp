#include "comm.hpp"

void Comm::print_log(const string action, const string msg)
{
		log << "[" << action << "]" << "\t" << msg << endl; 
};

template<class T>
void Comm::print_log(const string action, int tag, int dest, T value)
{
	log << "[" << action << " " << explain_msg(tag) << "]" 
		<< "\t" << dest 
		<< "\t" << value << endl; 
}

template<class T = MatrixXd>
void Comm::print_log (const string action, int tag, int dest, MatrixXd value)
{
	log << "[" << action << " " << explain_msg(tag) << "]" 
		<< "\t" << dest 
		<< "\t" << value.rows() << "*" << value.cols() 
		<< " matrix" << endl; 
}

void Comm::print_log_end()
{
	log << "--------------------------------------------" << endl;
};

/* p to p send message with context send matrix and tag to dest */
template<class T>
void Comm::msend(boost::mpi::communicator& world, int dest, int tag, T value)
{
	world.send(dest, tag, value);
	if(comm_verbose_level > 0)
	{
		print_log("send", tag, dest, "send with ", value);
		print_log_end();
	}
}

/* p-to-p receive message with context recv_matrix and tag from source */
template<class T>
void Comm::mrecv(boost::mpi::communicator& world, int source, int tag, T& value)
{
	world.recv(source, tag, value);
	if(comm_verbose_level > 0)
	{
		print_log("recv", tag, source, "recv with", value);
		print_log_end();
	}
}


