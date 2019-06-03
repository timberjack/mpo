#include "systemc.h"

SC_MODULE(ref_clk) {
	sc_out<bool> sclk;

	void clock()
	{
		sclk.write( false );
		wait(0.01356/13.56e6,SC_SEC);
		while (true) {
			sclk.write( true );
			wait(0.5/13.56e6,SC_SEC);
			sclk.write( false);
			wait(0.5/13.56e6,SC_SEC);
		}
	};

	SC_CTOR(ref_clk)
	{
		SC_THREAD(clock);
	}
};
