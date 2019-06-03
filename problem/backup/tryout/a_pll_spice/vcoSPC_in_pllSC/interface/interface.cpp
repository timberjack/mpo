#include "interface.h"
#include "run_spv2.cpp"

//double sp_ckt(double output_time[100000], double output_voltage[100000], double local_t);
	
	void interface::initialize()
	{
		ifstream myFile;
		
		myFile.open("pll_test.txt");
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
