#include <systemc-ams.h>
#include "systemc.h"

#include "clk.cpp"
#include "PFD.cpp"
#include "pll_lpf.cpp"
#include "vco.cpp"

int sc_main(int argc, char* argv[]) {
	
	sc_core::sc_set_time_resolution(1.0, sc_core::SC_FS);

	sc_core::sc_signal<bool> ref, vo, dvo;
	sc_core::sc_signal<double> lpf_in, lpf_out;

	ref_clk		RC("ref_clock");
	phfd		PD("phf_dtct");
	pll_lpf		LF("loop_flt", 5e3, 144e-12, 16e-12, (0.01/13.56e6));	// r_val, c1_val, c2_val, Tm_
	vc_osc		OC("vc_vco", 0e6, 1.2, 2.2e7, (0.01/13.56e6));	// fc_, ampl_, K_, tm_

	RC.sclk(ref);

	PD.volt(lpf_out);
	PD.ref(ref);	PD.ocs(vo);	//PD.ocs(dvo);
	PD.up_dn(lpf_in);
	
	LF.in(lpf_in);
	LF.out(lpf_out);

	OC.in(lpf_out);
	OC.out(vo);

/*
	sca_util::sca_trace_file* atf1 = sca_util::sca_create_vcd_trace_file("test_pll_sysC.vcd");
	sca_util::sca_trace(atf1, ref, "0_ref_clk");
	sca_util::sca_trace(atf1, vo, "1_vco_out");
//	sca_util::sca_trace(atf1, PD.Qup, "2a_up");
//	sca_util::sca_trace(atf1, PD.Qdn, "2b_dn");
//	sca_util::sca_trace(atf1, lpf_in, "2_err_sig");
	sca_util::sca_trace(atf1, lpf_out, "3_ctrl_v");
//	sca_util::sca_trace(atf1, OC.vco_sin, "4_vco_sine");
//	sca_util::sca_trace(atf1, dvo, "5_*N_clk");
	sc_core::sc_start(10, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
*/

			remove("vc_sysC.txt");			
	sca_util::sca_trace_file* atf1 = sca_util::sca_create_tabular_trace_file( "test_pll_sysC.dat" );
//	sca_util::sca_trace(atf1, ref, "0_ref_clk");
//	sca_util::sca_trace(atf1, vo, "1_vco_out");
	sca_util::sca_trace(atf1, lpf_in, "2_err_sig");
	sca_util::sca_trace(atf1, lpf_out, "3_ctrl_v");
	sc_core::sc_start(10, sc_core::SC_US);
	sca_util::sca_close_vcd_trace_file( atf1 );
			ofstream file("vc_sysC.txt", ios::out | ios::app);
			file << ".ENDDATA" << endl;
			file.close();

//	atf1->reopen("test_pll_freq.dat");
//	atf1->set_mode(sca_util::sca_ac_format(sca_util::SCA_AC_MAG_RAD));
//	sca_ac_analysis::sca_ac_start(1e0, 1e10, 11, sca_ac_analysis::SCA_LOG);
//	sca_util::sca_close_tabular_trace_file( atf1 );

/*
//	sca_util::sca_trace_file* atf1 = sca_util::sca_create_tabular_trace_file( "test_pll_freq" );
//	sca_util::sca_trace(atf1, ref, "0_ref_clk");
//	sca_util::sca_trace(atf1, vo, "1_vco_out");
	sca_util::sca_trace(atf1, lpf_out, "3_ctrl_v");
	set_mode(sca_util::sca_ac_format(sca_util::SCA_AC_MAG_RAD));
	sca_ac_analysis::sca_ac_start(1e3, 1e10, 10, sca_ac_analysis::SCA_LOG);
	sca_util::sca_close_tabular_trace_file( atf1 );
*/
	return 0;
}
