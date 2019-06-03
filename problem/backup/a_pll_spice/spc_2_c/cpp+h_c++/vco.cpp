#include "vco.h"
#include "run_spv2.cpp"
//double sp_ckt(double output_time[100000], double output_voltage[100000], double local_t);

	void vc_osc::set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);	//	nfc_squ.set_delay(16/2);
	}

	void vc_osc::processing()
	{
		double local_t = get_time().to_seconds();
	//	v_ctrl = local_t * 0.2e6;
		v_ctrl = sp_ckt(output_time, output_voltage, local_t);

		if (v_ctrl > 1.2 ) volt_limit = 1.2;
		else if (v_ctrl < 0 ) volt_limit = 0;
		else volt_limit = v_ctrl;

		freq = fc + K * volt_limit;
		theta = theta + 2 * M_PI * tm * freq;
		vco_sin = ampl*std::cos(theta);

		if (vco_sin>0)	out.write( true );
		else 			out.write( false );
		
	}
