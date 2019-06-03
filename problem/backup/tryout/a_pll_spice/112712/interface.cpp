#include "interface.h"
#include "run_spv2.cpp"
	
	void interface::initialize()
	{
		ifstream myFile;

		myFile.open("invco.tr0");
		pp = &p;
		p = myFile.tellg();	
		//cout<<*pp<<'\n';
	}
	
	void interface::set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);	//	nfc_squ.set_delay(16/2);
	}

	void interface::processing()
	{
		double local_t = get_time().to_seconds();
		out = sp_ckt(local_t, pp);
	}
