#ifndef	_VCO_H
#define	_VCO_H

#include "systemc.h"
#include <systemc-ams.h>

//#include "run_spv2.cpp"
//double sp_ckt(double output_time[100000], double output_voltage[100000], double local_t);

SCA_TDF_MODULE(vc_osc)
{
	sca_tdf::sca_de::sca_in <double> vc;
	sca_tdf::sca_de::sca_out<bool> vcob;

	vc_osc( sc_core::sc_module_name nm, double fc_= 4.8e6, double ampl_= 1.0, double K_ = 5e5, double tm_ = 1e-8 )
	: vc("vc"), vcob("vcob"),
	  fc(fc_), ampl(ampl_), K(K_), tm(tm_) {}

	void initialize();
	void set_attributes();
	void processing();

	private:
		double fc, ampl, K, tm;
		double volt_limit, freq, theta, vco_sin;
};

#endif
