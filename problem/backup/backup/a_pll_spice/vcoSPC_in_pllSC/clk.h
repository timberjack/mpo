#ifndef	_CLK_H
#define	_CLK_H

#include "systemc.h"

SC_MODULE(ref_clk) {
	sc_out<bool> sclk;

	void clock();

	SC_CTOR(ref_clk)
	{
		SC_THREAD(clock);
	}
};

#endif
