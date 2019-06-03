#include "vco.h"

	void vc_osc::initialize()
	{
	//	ofstream file("vc_pwl.data", ios::out | ios::app);
	//	file << "+ )" << endl;
	//	file.close();
		file.open("vc_pwl.data", ios::out | ios::trunc);
		file << "vc vc 0 PWL (" << endl;

		int done;
		done = system("ngspice -b -r invco.tr0 -o invco.log invco.cir");
		if(!done) printf("ngspice Done!\n");
		else printf("ngspice Not Done\n");		//	printf("ngspice is executed here!\n");
	}

	void vc_osc::set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);	//	nfc_squ.set_delay(16/2);
	}

	void vc_osc::processing()
	{
		double local_time = get_time().to_seconds();
			file << "+ " << local_time << " " << vc << endl;

		// replace this part by energy product solution
		if ( vo_in.read() > 0.7 ) vcob.write( true );
		else if ( vo_in.read() < 0.3 ) vcob.write( false );

		//if ( vo_in.read() > 0.6 ) vcob.write( true );
		//else vcob.write( false );

	/*	if ( vc.read() > 1.2 ) volt_limit = 1.2;
		else if ( vc.read() < 0 ) volt_limit = 0;
		else volt_limit = vc.read();

		freq = fc + K * volt_limit;
		theta = theta + 2 * M_PI * tm * freq;
		vco_sin = ampl*std::cos(theta);

		if (vco_sin>0)	vcob.write( true );
		else 			vcob.write( false );
	*/		
	}
