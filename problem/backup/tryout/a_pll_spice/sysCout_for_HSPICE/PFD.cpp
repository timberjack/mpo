#include "systemc.h"
#include <systemc-ams.h>

SC_MODULE(phfd) {
	sc_in<double> volt;
	sc_in<bool> ref, ocs;
	sc_out<double> up_dn;

	sc_signal<bool> Qup, Qdn, rst;

	void proc0()
	{
		if (( volt < 0.01 ) && Qdn)	{
			up_dn.write(0);			rst = true;
		}
		else if (( volt >= 1.19 ) && Qup)	{
			up_dn.write(0);			rst = true;
		}
		else {
			if ( Qup & !Qdn )	{
					up_dn.write(50e-6);		rst = false;
				}
				else if ( !Qup & Qdn )	{
					up_dn.write(-50e-6);	rst = false;
				}
				else if ( Qup & Qdn )	{
					up_dn.write(0);			rst = true;
				}
				else	{
					up_dn.write(-25e-12);	rst = false;
				}
		}
		//	double local_time = get_time().to_seconds();
	};

	void proc1()
	{
		if ( rst )	Qup = false;
		else if ( ref.event() )	Qup = true;
	};
	void proc2()
	{
		if ( rst )	Qdn = false;
		else if ( ocs.event() )	Qdn = true;
	};

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
