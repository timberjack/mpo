#include "systemc.h"
#include <systemc-ams.h>


//#include <cstdio>			/*input and output and is typically included in all C programs*/
//#include <cstdlib>		/*includes functions involving memory allocation, process control, conversions and others*/
//#include <cstring>		/*contains macro definitions, constants, and declarations of functions and types used not only for string handling
//							but also various memory handling functions*/
//#include <iostream>
//using namespace std;

SCA_TDF_MODULE(vc_osc)
{
	sca_tdf::sca_de::sca_in <double> in;
	sca_tdf::sca_de::sca_out<bool> out;

    sc_signal<double> freq;
	sc_signal<double> vco_sin;
	sc_signal<double> volt_limit;

	vc_osc( sc_core::sc_module_name nm, double fc_= 12e6, double ampl_= 1.2, double K_ = 2e6, double tm_ = (0.01/13.56e6) )
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
		if (in.read() > 1.2 ) volt_limit = 1.2;
		else if (in.read() < 0 ) volt_limit = 0;
		else volt_limit = in.read();

		freq = fc + K*volt_limit;
		theta = theta + 2 * M_PI * tm * freq;
		vco_sin = ampl*std::cos(theta);

		if (vco_sin>0)	out.write( true );
		else 			out.write( false );


		double local_time = get_time().to_seconds();
		ifstream file;
		file.open("vc_pwl.data");
		if ( !file.is_open() ) {
			ofstream file("vc_pwl.data");
			file << "vc vc 0 PWL (" << endl;
			file << "+ " << local_time << " " << in << endl;
			//file << "+ 0 0" << endl;
		}
		else {
			ofstream file("vc_pwl.data", ios::out | ios::app);
			file << "+ " << local_time << " " << in << endl;
		}
	};

	private:
		double fc, ampl, K, tm;
		double theta;
};
