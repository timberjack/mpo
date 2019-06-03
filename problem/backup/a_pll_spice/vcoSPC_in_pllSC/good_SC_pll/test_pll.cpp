#include <systemc-ams.h>
#include "systemc.h"

#include "clk.h"
#include "PFD.h"
#include "pll_lpf.h"
//#include "interface.h"
#include "vco.h"

int sc_main(int argc, char* argv[]) {

	sc_core::sc_set_time_resolution(1.0, sc_core::SC_FS);

	sc_core::sc_signal<bool> ref, vo;
	sc_core::sc_signal<double> ch_crt, vc;
//	sca_tdf::sca_signal<bool> vo, vc;

	ref_clk		RC("ref_clock");
	phfd		PD("phf_dtct");
	pll_lpf		LF("loop_flt", 5e3, 144e-12, 16e-12, (0.01/13.56e6));	// r_val, c1_val, c2_val, Tm_
//	interface	ITF("interface", (0.01/13.56e6) );				// tm_
	vc_osc		OCS("vc_vco", 0e6, 1.2, 2.2e7, (0.01/13.56e6));	// fc_, ampl_, K_, tm_

	RC.sclk(ref);
	PD.volt(vc);
	PD.ref(ref);	PD.ocs(vo);
	PD.up_dn(ch_crt);
	LF.in(ch_crt);	LF.out(vc);
	OCS.vc(vc);		OCS.vcob(vo);
//	ITF.out(vc);

	sca_util::sca_trace_file* atf1 = sca_util::sca_create_vcd_trace_file("pll_SPICE_sysC.vcd");
	sca_util::sca_trace(atf1, vc, "v_ctrl");
	sca_util::sca_trace(atf1, vo, "vco_out");
	sc_core::sc_start(5, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
	return 0;
}