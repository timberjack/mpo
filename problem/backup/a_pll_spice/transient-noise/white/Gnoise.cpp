#include <systemc-ams.h>
#include <cstdlib>			// for std::rand
#include <cmath>			// for std::sqrt and std::log

/*
double gauss_rand(double variance)				// the gauss_rand() function returns a gaussian distributed
{
	double rnd1, rnd2, Q, Q1, Q2;				// random number with variance "variance", centered around 0, using the Marsaglia polar method
	
	do {
		rnd1 = ((double)std::rand()) / ((double)RAND_MAX) ;
		rnd2 = ((double)std::rand()) / ((double)RAND_MAX) ;
		Q1 = 2.0 * rnd1 - 1.0 ;
		Q2 = 2.0 * rnd2 - 1.0 ;
		Q = Q1 * Q1 + Q2 * Q2 ;
	}
	while (Q > 1.0) ;
	return ( std::sqrt(variance) *( std::sqrt( - 2.0 * std::log(Q) / Q) * Q1) );
};
*/

SCA_TDF_MODULE(G_noise)
{
//	sca_tdf::sca_in<double> in;
	sca_tdf::sca_out<double> GNO;
//	sca_tdf::sca_out<double> out;

	G_noise( sc_core::sc_module_name n, double tm_= 1e-8, double attenuation_= 1, double variance_= 1 )
	: //in("in"), out("out"),
	  GNO("GNO"), tm(tm_), attenuation(attenuation_), variance(variance_) {}

	void set_attributes()
	{
		set_timestep(tm, sc_core::SC_SEC);
	}
	
	void processing()
	{
		do
		{
			rnd1 = ((double)std::rand()) / ((double)RAND_MAX) ;
			rnd2 = ((double)std::rand()) / ((double)RAND_MAX) ;
			Q1 = 2.0 * rnd1 - 1.0 ;		Q2 = 2.0 * rnd2 - 1.0 ;
			Q = Q1 * Q1 + Q2 * Q2 ;
		}
	
		while (Q > 1.0) ;
		gauss_rand = std::sqrt(variance) *( std::sqrt( - 2.0 * std::log(Q) / Q) * Q1);
		
		GNO.write(gauss_rand);
	//	out.write(in.read()*attenuation + gauss_rand);

	}
	
  private:
  double tm, attenuation, variance, gauss_rand;
  double rnd1, rnd2, Q, Q1, Q2;				// random number with variance "variance", centered around 0, using the Marsaglia polar method
};


/*
Gnoise.o: In function `gauss_rand(double)':
Gnoise.cpp:(.text+0x60): multiple definition of `gauss_rand(double)'
BASK.o:BASK.cpp:(.text+0x60): first defined here

/tmp/ccRJX6KO.o: In function `gauss_rand(double)':
test_BASK.cpp:(.text+0x60): multiple definition of `gauss_rand(double)'
BASK.o:BASK.cpp:(.text+0x60): first defined here


collect2: ld returned 1 exit status
make: *** [test_BASK] Error 1
*/
