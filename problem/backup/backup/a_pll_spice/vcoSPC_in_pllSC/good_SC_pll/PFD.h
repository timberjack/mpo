#ifndef	_PFD_H
#define	_PFD_H

#include "systemc.h"

SC_MODULE(phfd) {
	sc_in<double> volt;
	sc_in<bool> ref, ocs;
	sc_out<double> up_dn;

	sc_signal<bool> Qup, Qdn, rst;

	void proc0();
	void proc1();
	void proc2();

	SC_CTOR(phfd)
	{
		SC_METHOD(proc0);
		sensitive << volt << Qup << Qdn;
		SC_METHOD(proc1);
		sensitive << rst << ref.pos();
		SC_METHOD(proc2);
		sensitive << rst << ocs.pos();
	}
};

#endif
