#include <systemc-ams.h>

SCA_TDF_MODULE(rectifier)
{
  sca_tdf::sca_in<double> in;
  sca_tdf::sca_out<double> out;
  
  SCA_CTOR(rectifier) : in("in"), out("out") {}
  
  void processing()
  {
  out.write( std::abs(in.read()) );
  }
};

////////////////////////////////////////////////////////////

SCA_TDF_MODULE(lowpass)
{
  sca_tdf::sca_in<double> in;
  sca_tdf::sca_out<double> out;
  
  lowpass( sc_core::sc_module_name nm, double fc_, double h0_ = 1.0 )
  : in("in"), out("out"), fc(fc_), h0(h0_) {}
  
  void set_attributes()					//void initialize()
  {
    num(0) = 1.0; den(0) = 1.0;
    den(1) = 1.0 /( h0 * 2.0 * M_PI * fc );
  }
  
  void processing()
  {
    out.write( ltf_nd( num, den, in.read(), h0 ) );
  }
  
  private:
  sca_tdf::sca_ltf_nd ltf_nd; 			 // Laplace transfer function
  sca_util::sca_vector<double> num, den; // numerator and denominator coefficients
  double fc; 							 // 3dB cut-off frequency in Hz
  double h0; 							 // DC gain
};

////////////////////////////////////////////////////////////


SCA_TDF_MODULE(bit_recov)
{
  sca_tdf::sca_in<double> in; 			// input port
  sca_tdf::sca_out<bool> out; 	// TDF converter output port to discrete-event domain
  
    bit_recov( sc_core::sc_module_name n, int rate_ = 40, double thresh_ = 0.2 )
    : in("in"), out("out"), rate(rate_), threshold(thresh_) {}

  void set_attributes()
  {
    in.set_rate(rate);
    sample_pos = (unsigned long)std::ceil( 2.0*(double)rate/3.0 );
    out.set_delay(1);
  }

  void processing()
  {
    if( in.read(sample_pos) > threshold )
    out.write(true);
    else
    out.write(false);
  }
  
  private:
  unsigned long rate;
  double threshold;
  unsigned long sample_pos;
};
