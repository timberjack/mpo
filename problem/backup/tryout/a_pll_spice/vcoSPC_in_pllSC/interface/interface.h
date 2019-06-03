#ifndef	_INTERFACE_H
#define	_INTERFACE_H

#include "systemc.h"
#include <systemc-ams.h>

//#include "run_spv2.cpp"
//double sp_ckt(double output_time[100000], double output_voltage[100000], double local_t);

SCA_TDF_MODULE(interface)
{				
	sca_tdf::sca_out<double> out;

	interface( sc_core::sc_module_name nm, double tm_ = 1e-8 )
	: out("out"),
	  tm(tm_) {}
	
	void initialize();
	void set_attributes();
	void processing();


	private:	double tm; streampos* pp; streampos p;
};

#endif
