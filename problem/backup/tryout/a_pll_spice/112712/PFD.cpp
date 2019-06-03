#include "PFD.h"

	void phfd::proc0()
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
	}
	

	void phfd::proc1()
	{
		if ( rst )	Qup = false;
		else if ( ref.event() )	Qup = true;
	}

	void phfd::proc2()
	{
		if ( rst )	Qdn = false;
		else if ( ocs.event() )	Qdn = true;
	}
