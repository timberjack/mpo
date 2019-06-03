#include "vco.h"

	void vc_osc::initialize()
	{
	/*	int done;
		done = system("ngspice -b -r invo.tr0 -o invo.log invo.cir");
		if(!done) printf("ngspice Done!\n");
		else printf("ngspice Not Done\n");
	*/
		printf("ngspice is executed here!\n");
	}

	void vc_osc::set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);	//	nfc_squ.set_delay(16/2);
	}

	void vc_osc::processing()
	{
		if ( vc.read() > 1.2 ) volt_limit = 1.2;
		else if ( vc.read() < 0 ) volt_limit = 0;
		else volt_limit = vc.read();

		freq = fc + K * volt_limit;
		theta = theta + 2 * M_PI * tm * freq;
		vco_sin = ampl*std::cos(theta);

		if (vco_sin>0)	vcob.write( true );
		else 			vcob.write( false );		
	}
