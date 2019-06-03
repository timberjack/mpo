#include "systemc.h"
#include <systemc-ams.h>

SCA_TDF_MODULE(vc_osc)
{
	sca_tdf::sca_in<double> in;
	sca_tdf::sca_out<bool> out;

    sc_signal<double> freq;
	sc_signal<double> vco_sin;
	sc_signal<double> volt_limit;

	vc_osc( sc_core::sc_module_name nm, double fc_= 4.8e6, double ampl_= 1.0, double K_ = 5e5, double tm_ = 1e-8 )
	: in("in"), out("out"),
	  freq("freq"), vco_sin("vco_sin"), volt_limit("volt_limit_"),
	  fc(fc_), ampl(ampl_), K(K_), tm(tm_)
	{}

	void set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);
//		nfc_squ.set_delay(16/2);
	}

	void processing()
	{
		if ( in.read() > 1.2 ) volt_limit = 1.2;
		else if ( in.read() < 0 ) volt_limit = 0;
		else volt_limit = in.read();

		freq = fc + K * volt_limit;
		theta = theta + 2 * M_PI * tm * freq;
		vco_sin = ampl*std::cos(theta);

		if (vco_sin>0)	out.write( true );
		else 			out.write( false );
		
	};

	private:
		double fc, ampl, K, tm;
		double theta;
};
