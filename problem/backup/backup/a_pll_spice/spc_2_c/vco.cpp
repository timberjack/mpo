#include "vco.h"

	void vc_osc::set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);	//	nfc_squ.set_delay(16/2);
	}

	void vc_osc::processing()
	{
		if ( in.read() > 1.2 ) volt_limit = 1.2;
		else if ( in.read() < 0 ) volt_limit = 0;
		else volt_limit = in.read();

		freq = fc + K * volt_limit;
		theta = theta + 2 * M_PI * tm * freq;
		vco_sin = ampl*std::cos(theta);

		if (vco_sin>0)	out.write( true );
		else 			out.write( false );		
	}
