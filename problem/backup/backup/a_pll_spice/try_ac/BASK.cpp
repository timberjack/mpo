// Instantiating and connecting

#include <systemc-ams.h>
#include "bask_modulation.cpp"
#include "demod_bask.cpp"


SC_MODULE(mod_bask_dem)
{
  sca_tdf::sca_in<bool>	in;
  sca_tdf::sca_out<bool> out;

  sin_src	sine;
  mixer		mix;
  rectifier	rec;
  lowpass	lps;
  bit_recov	btr;

  SC_CTOR(mod_bask_dem)
  : in("in"), out("out"),
    sine("sine", 1.0, 5.0e7, sca_core::sca_time( 1.0, sc_core::SC_NS ) ),
    mix("mix"),
    rec("rec"),
    lps("lps", 1.67e7, 1.0),		// lp("lp", freq/3.0, h0),
    btr("btr", 200, 0.2)		// br("br", rate, thresh)

  {
    sine.out(carrier);
    mix.in_wav(carrier);
    mix.in_bin(in);
    mix.out(bask_out);
    rec.in(bask_out);
    rec.out(rec_wv);
    lps.in(rec_wv);
    lps.out(lps_wv);
    btr.in(lps_wv);
    btr.out(out);
  }

 private:
  sca_tdf::sca_signal<double> carrier, bask_out;
  sca_tdf::sca_signal<double> rec_wv, lps_wv;
};
