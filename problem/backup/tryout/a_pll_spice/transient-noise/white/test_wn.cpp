#include <systemc-ams.h>
#include "systemc.h"

#include "Gnoise.cpp"

int sc_main(int argc, char* argv[]) {
	
	sc_core::sc_set_time_resolution(1.0, sc_core::SC_FS);

	sca_tdf::sca_signal<double> white_noise;

	G_noise		WN("GNG", (0.01/13.56e6));	// tm_, attenuation_, variance_

	WN.GNO(white_noise);

	sca_util::sca_trace_file* atf1 = sca_util::sca_create_tabular_trace_file( "white_noise.dat" );
	sca_util::sca_trace(atf1, white_noise, "white");
	sc_core::sc_start(10, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
/*
	sca_util::sca_trace_file* atf1 = sca_util::sca_create_vcd_trace_file("vco_SPICE_sysC.vcd");
	sca_util::sca_trace(atf1, vc, "Vc");
	sca_util::sca_trace(atf1, vo, "vco_out");
	sc_core::sc_start(4.5, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
*/
	return 0;
}
