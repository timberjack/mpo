#include <systemc-ams.h>
#include "systemc.h"

#include "vco.h"

int sc_main(int argc, char* argv[]) {
	
	sc_core::sc_set_time_resolution(1.0, sc_core::SC_FS);

	sc_core::sc_signal<bool> vo;
	vc_osc		OC("vc_vco", 0e6, 1.2, 2.2e7, (0.01/13.56e6));	// fc_, ampl_, K_, tm_
	OC.out(vo);

	sca_util::sca_trace_file* atf1 = sca_util::sca_create_vcd_trace_file("vco_SPICE_sysC.vcd");
	sca_util::sca_trace(atf1, OC.v_ctrl, "Vc");
	sca_util::sca_trace(atf1, vo, "vco_out");
	sc_core::sc_start(4.5, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
	return 0;
}
