#include<iostream>
#include<fstream>
#include<stdlib.h>
#include<pthread.h>
#include<string>
#include<sstream>
#include<ctype.h>
//#include <cstdlib>	// for std::rand
//#include <cmath>	// for std::sqrt and std::log
using namespace std;

#include <systemc-ams.h>

SCA_TDF_MODULE(spv)
{
	double output_time[100000];
	double output_voltage[100000];

	sca_tdf::sca_out<double> out;

	spv( sc_core::sc_module_name nm, double tm_ = 1e-8 )
	: out("out"),
	  tm(tm_) {}

	void set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);
	}

	void processing()
	{
		double local_t = get_time().to_seconds();
		out.write( local_t * 0.2e6 );	//	v_ctrl = local_t * 0.2e6;
		
/*
	double vc;
	double output_time[100000], output_voltage[100000];
	int done = 1;
	ifstream myFile;
	string output[100000], output_temp, output_temp2;
	
	unsigned int i=0,j=0;
	int size_of_output;

	myFile.open("pll_test.txt");
	if(myFile.is_open())
	{
		while(!myFile.eof())
		{
			getline(myFile,output[i]);
			i++;
		}
	}
	myFile.close();
	size_of_output = i;

	for(i=10;i<size_of_output-2;i=i+2)
	{
		j=0;
		while(!isspace(output[i][j])) j++;
		
		output_temp = output[i].substr(j+2,output[i].length());
		output_temp2 = output[i+1].substr(1,output[i+1].length());

		stringstream ss(output_temp);
		ss >> output_time[i];
		stringstream ss1(output_temp2);
		ss1 >> output_voltage[i];

		cout << output_time[i] << '\t' << output_voltage[i] << '\n';
	}

	out.write( vc );	// return (vc);
*/

	};

	private:
		double tm;
};
