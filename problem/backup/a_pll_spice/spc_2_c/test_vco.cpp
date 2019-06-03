#include <systemc-ams.h>
#include "systemc.h"

#include "vco.h"
#include "interface.h"
#include "call_spice.h"

int sc_main(int argc, char* argv[]) {

	sc_core::sc_set_time_resolution(1.0, sc_core::SC_FS);

	sca_tdf::sca_signal<bool> vo;
	sca_tdf::sca_signal<bool> dummy;
	sca_tdf::sca_signal<double> vc;

	spice		SPC("spice", 4.5e-6);				// tm_
	interface	ITF("interface", (0.01/13.56e6) );	// tm_
	vc_osc		OCS("vc_vco", 0e6, 1.2, 2.2e7, (0.01/13.56e6));	// fc_, ampl_, K_, tm_

	SPC.dummy(dummy);
	ITF.out(vc);
	OCS.in(vc);
	OCS.out(vo);

	sca_util::sca_trace_file* atf1 = sca_util::sca_create_vcd_trace_file("vco_SPICE_sysC.vcd");
//	sca_util::sca_trace(atf1, OC.v_ctrl, "Vc");
	sca_util::sca_trace(atf1, vc, "v_ctrl");
	sca_util::sca_trace(atf1, vo, "vco_out");
	sc_core::sc_start(4.5, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
	return 0;
}
