#ifndef	_VCO_H
#define	_VCO_H

#include "systemc.h"
#include <systemc-ams.h>

//#include "run_spv2.cpp"
//double sp_ckt(double output_time[100000], double output_voltage[100000], double local_t);

SCA_TDF_MODULE(vc_osc)
{
	sca_tdf::sca_de::sca_out<bool> out;

	double output_time[100000], output_voltage[100000];	// this might be gone due to re-assign memory location
    sc_signal<double> v_ctrl;
    sc_signal<double> volt_limit, freq, theta, vco_sin;

	vc_osc( sc_core::sc_module_name nm, double fc_= 4.8e6, double ampl_= 1.0, double K_ = 5e5, double tm_ = 1e-8 )
	: out("out"),
	  v_ctrl("v_ctrl"), volt_limit("volt_limit_"), freq("freq"), theta("theta"), vco_sin("vco_sin"),
	  fc(fc_), ampl(ampl_), K(K_), tm(tm_) {}

	void set_attributes();
	void processing();

	private:	double fc, ampl, K, tm;
};

#endif
