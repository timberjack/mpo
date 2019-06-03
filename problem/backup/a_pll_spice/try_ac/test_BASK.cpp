#include <systemc-ams.h>
#include "BASK.cpp"


int sc_main(int argc, char* argv[])
{
	
  sc_core::sc_set_time_resolution(1, sc_core::SC_FS);
  sca_tdf::sca_signal<bool> sig1;
  sca_tdf::sca_signal<bool> sig2;
		
  bit_src bs("bs");
  mod_bask_dem bm("bm");
  bs.out(sig1);	
  bm.in(sig1);
  bm.out(sig2);


  sca_util::sca_trace_file* atf1 = sca_util::sca_create_tabular_trace_file( "bask_time.dat" ); 
  sca_util::sca_trace(atf1, sig1, "bm_in");
  sca_util::sca_trace(atf1, bm.sine.out, "carrier");
  sca_util::sca_trace(atf1, bm.mix.out, "bask_out");
  sca_util::sca_trace(atf1, bm.rec.out, "rec_wv");
  sca_util::sca_trace(atf1, bm.lps.out, "lps_wv");
  sca_util::sca_trace(atf1, sig2, "bm_out");
  sc_core::sc_start(10, sc_core::SC_US);

	atf1->reopen("bask_freq.dat");
	atf1->set_mode(sca_util::sca_ac_format(sca_util::SCA_AC_MAG_RAD));
	sca_ac_analysis::sca_ac_start(1e0, 1e10, 22, sca_ac_analysis::SCA_LOG);
  sca_util::sca_close_tabular_trace_file( atf1 );

  return 0;
}
