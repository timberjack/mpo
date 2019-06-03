#include <systemc-ams.h>

SCA_TDF_MODULE(bit_src)
{
  sca_tdf::sca_out<bool> out; // output port

  SCA_CTOR(bit_src) : out("out") {}
  void set_attributes()
    {
      set_timestep(sca_core::sca_time(100, sc_core::SC_NS));
    }
  void processing()
  {
    out.write( (bool)(std::rand()%2) );
  }
};

////////////////////////////////////////////////////////////

SCA_TDF_MODULE(sin_src)
{
  sca_tdf::sca_out<double> out; // output port

  sin_src(
		sc_core::sc_module_name nm, double ampl_= 1.0, double freq_ = 1.0e3,
           sca_core::sca_time Tm_ = sca_core::sca_time(0.125, sc_core::SC_MS) )
         
  : out("out"), ampl(ampl_), freq(freq_), Tm(Tm_)
  {}
  void set_attributes()
  {
    //set_timestep(Tm);
  }
  void processing()
  {
    double t = get_time().to_seconds(); // actual time
    out.write( ampl * std::sin( 2.0 * M_PI * freq * t ) );
  }
 private:
  double ampl; // amplitude
  double freq; // frequency
  sca_core::sca_time Tm; // module time step
};

////////////////////////////////////////////////////////////

SCA_TDF_MODULE(mixer)
{
  sca_tdf::sca_in<bool>    in_bin;   // input port baseband signal
  sca_tdf::sca_in<double>  in_wav;   // input port carrier signal
  sca_tdf::sca_out<double> out;      // output port modulated signal
  SCA_CTOR(mixer)
  : in_bin("in_bin"), in_wav("in_wav"), out("out"), rate(200) {}  // use a carrier data rate of 40

  void set_attributes()
  {
    in_wav.set_rate(rate);
    out.set_rate(rate);
  }

  void processing()
  {
    for(unsigned long i = 0; i < rate; i++)
    {
      if ( in_bin.read() )
        out.write( in_wav.read(i), i );
      else
        out.write( 0.0, i );
    }
  }
private:
  unsigned long rate;
};
