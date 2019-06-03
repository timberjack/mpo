#include <systemc-ams.h>
#include "flicker.cpp"

int sc_main(int argc, char* argv[])
{
  sc_core::sc_set_time_resolution(1, sc_core::SC_FS);

  sca_tdf::sca_signal<double>  noise;
  flk_noise fn("fn");

  fn.x1(noise);
  fn.x2(noise);
/*
	sca_util::sca_trace_file* atf1 = sca_util::sca_create_vcd_trace_file("1-f_noise"); 
	sca_util::sca_trace(atf1, noise, "1/f");
	sc_core::sc_start(10, sc_core::SC_MS);
	sca_util::sca_close_vcd_trace_file(atf1);
*/
  sca_util::sca_trace_file* atf2 = sca_util::sca_create_tabular_trace_file("1-f_noise.dat"); 
  sca_util::sca_trace(atf2, noise, "1/f");
  sc_core::sc_start(10, sc_core::SC_MS);
  sca_util::sca_close_tabular_trace_file(atf2);

return 0;
}
