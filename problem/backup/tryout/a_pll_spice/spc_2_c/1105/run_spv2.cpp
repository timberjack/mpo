#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include <sstream>
#include <ctype.h>
//#include <cstdlib>	// for std::rand
//#include <cmath>	// for std::sqrt and std::log
using namespace std;

#include <systemc-ams.h>

SCA_TDF_MODULE(spv)
{
//	double output_time[100000];
//	double output_voltage[100000];

	sca_tdf::sca_out<double> out;
	
	sc_signal<double> t1, vc1, t2, vc2;
	//sc_signal<int> i;
	
	spv( sc_core::sc_module_name nm, double tm_ = 1e-8)
	: out("out"),
	  tm(tm_) {}

	void set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);
	}

	void processing()
	{
		double local_t = get_time().to_seconds();
		
		int done = 1;
		ifstream myFile;
		string substr_t1, substr_t2, substr_vc1, substr_vc2, str_t1, str_t2, str_vc1, str_vc2;
		double vc_1, vc_2, t_1,t_2;
	
		unsigned int i=0,j=0;
		
		myFile.open("pll_test.txt");
		if(myFile.is_open())
		{
				while(!myFile.eof())
				{
					if(i<10)
					{
						getline(myFile,str_t1);
						i++;
					}
					
					
					else if(i>=10)
					{
						getline(myFile,str_t1);
						getline(myFile,str_vc1);
						getline(myFile,str_t2);
						getline(myFile,str_vc2);
						
						j=0;
						while(!isspace(str_t2[j])) j++;
						substr_t2 = str_t2.substr(j+2,str_t2.length());
						stringstream ss(substr_t2);
						ss >> t_2;
						
						j=0;
						while(!isspace(str_t1[j])) j++;
						substr_t1 = str_t1.substr(j+2,str_t1.length());
						stringstream ss1(substr_t1);
						ss1 >> t_1;
					
						j=0;
						while(!isspace(str_vc1[j])) j++;
						substr_vc1 = str_vc1.substr(1,str_vc1.length());
						stringstream ss2(substr_vc1);
						ss2 >> vc_1;
												
						j=0;
						while(!isspace(str_vc2[j])) j++;
						substr_vc2 = str_vc2.substr(1,str_vc2.length());
						stringstream ss3(substr_vc2);
						ss3 >> vc_2;

						
						if(t_2>local_t)
						{
							vc1=vc_1;
							vc2=vc_2;
							t1=t_1;
							t2=t_2;
							out.write( (vc1+vc2)/2 );
							break;
						}
						
						else if(t_2 == local_t)
						{
							vc2=vc_2;
							t2=t_2;
							out.write(vc2);
							break;
						}
						
						else if(t_1 == local_t)
						{
							vc1=vc_1;
							t2=t_2;
							out.write(vc1);
							break;
						}
					}
				}
	}
	myFile.close();
	
	
	};
	
	private:
		double tm;
};
