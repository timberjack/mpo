#ifndef	_CALL_SPICE_H
#define	_CALL_SPICE_H

#include "systemc.h"
#include <systemc-ams.h>

SCA_TDF_MODULE(spice)
{
	sca_tdf::sca_out<bool> dummy;

	spice( sc_core::sc_module_name nm, double tm_ = 1e-8 )
	: dummy("dummy"), tm(tm_) {}

	void set_attributes();
	void processing();

	private:	double tm;
};

#endif
