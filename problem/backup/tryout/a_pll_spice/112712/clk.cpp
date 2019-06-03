#include "clk.h"

	void ref_clk::clock()
	{
		sclk.write( false );
		wait(0.01356/13.56e6,SC_SEC);
		while (true) {
			sclk.write( true );
			wait(0.5/13.56e6,SC_SEC);
			sclk.write( false);
			wait(0.5/13.56e6,SC_SEC);
		}
	}
