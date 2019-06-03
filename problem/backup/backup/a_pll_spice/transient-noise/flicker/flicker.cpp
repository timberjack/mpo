#include <systemc-ams.h>

SCA_TDF_MODULE(flk_noise)
{
  sca_tdf::sca_in <double> x1;
  sca_tdf::sca_out<double> x2;

  SCA_CTOR(flk_noise) : x1("x1"), x2("x2") {}

  void initialize()
  {
	srand ( time(NULL) );	b = std::rand()%100;
	if ( b==0 ) a = 0.01;	else a = b/100;
	x1.initialize( a );		// cout << b << endl << a << endl;
  }

  void set_attributes()
  {
	set_timestep(1/1e6,SC_SEC);
	x2.set_delay(1);
  }

  void processing()
  {
	
	x2.write( (x1.read() + x1.read()*x1.read()) - int(x1.read() + x1.read()*x1.read()) );
/*	a = x1.read() + x1.read()*x1.read();
	b = int(x1.read() + x1.read()*x1.read());
	x2.write( a-b );	// x_t_ = (x_t-1_ + x_t-1_^2) mod 1, this noise is low!
*/
  }

 private:
  double a, b;
};
