#include "call_spice.h"

	void spice::set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);	//	nfc_squ.set_delay(16/2);
	}

	void spice::processing()
	{
	/*	int done;
		done = system("ngspice -b -r invo.tr0 -o invo.log invo.cir");
		if(!done) printf("ngspice Done!\n");
		else printf("ngspice Not Done\n");
	*/
		dummy.write( true );	printf("ngspice is executed here!\n");
	}
