#ifndef	_PLL_LPF_H
#define	_PLL_LPF_H

#include <systemc-ams.h>

SC_MODULE(pll_lpf)
{
	sc_core::sc_in <double> in;	
	sc_core::sc_out<double> out;

	sca_eln::sca_de_isource iin;
	sca_eln::sca_de_vsink vout;
	sca_eln::sca_r r;
	sca_eln::sca_c c1, c2;

  pll_lpf( sc_core::sc_module_name, double r_val = 10e3, double c1_val = 100e-12, double c2_val = 10e-12, double Tm_ = (0.01/13.56e6) )
  :	in("in"), out("out"),
	iin("iin"), vout("vout"), r("r", r_val), c1("c1", c1_val), c2("c2", c2_val),
	a("a"), b("b"), gnd("gnd"),
	Tm(Tm_)
	{
		iin.inp(in);	iin.p(gnd);	iin.n(a);
		iin.set_timestep(Tm, sc_core::SC_SEC);
		r.p(a);		r.n(b);
		c1.p(b);	c1.n(gnd);
		c2.p(a);	c2.n(gnd);
		vout.p(a);	vout.n(gnd);	vout.outp(out);
	}

	private:
	sca_eln::sca_node a,b;
	sca_eln::sca_node_ref gnd;
	double Tm;
};

#endif
