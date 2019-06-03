#ifndef	_VCO_H
#define	_VCO_H

#include "systemc.h"
#include <systemc-ams.h>


SCA_TDF_MODULE(vc_osc)
{
	sca_tdf::sca_de::sca_in <double> vc;
	sca_tdf::sca_in<double> vo_in;
	sca_tdf::sca_de::sca_out<bool> vcob;

	vc_osc( sc_core::sc_module_name nm, double tm_ = 1e-8 )
	: vc("vc"), vo_in("vo_in"), vcob("vcob"), tm(tm_) {}

//	vc_osc( sc_core::sc_module_name nm, double fc_= 4.8e6, double ampl_= 1.0, double K_ = 5e5, double tm_ = 1e-8 )
//	: vc("vc"), vcob("vcob"),
//	  fc(fc_), ampl(ampl_), K(K_), tm(tm_) {}

	void initialize();
	void set_attributes();
	void processing();

	private:
		double tm;
		ofstream file;
//		double fc, ampl, K, tm;
//		double volt_limit, freq, theta, vco_sin;
};

#endif
