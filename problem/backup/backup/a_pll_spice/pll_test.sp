*Buck converter with ADPLL
** HSPICE RF Simulation Options :
.option sim_accuracy=10		*simulation data accuracy
.option ingold=1			*science math. record (x.y*10ez)
.option POST=2				*control output ?
.option nomod				*not listing process file in data output file

.include "model013.lib_inc"
.inc basic.sp
.inc pfd.sp
.inc pll.sp

x1 vdd 0 vo vo vc  vcdl
x2 vdd 0 up down ref vo  pfd
xinv vdd 0 upb up  inv_min
x3 vdd 0 upb down vc  chargepump

vdd vdd 0 1.2
vref ref 0 pulse 0 1.2 1n 7n 7n 30n 73.746313n
.ic v(vo)=1.2 v(vc)=0
.tran 100p 10u 

.save v(vc)
*.print v(vo) v(vc) v(ref) i(x3.m5) i(x3.m6)
*.probe v(vo) v(vc) v(ref) i(x3.m5) i(x3.m6)

.control
run
set filetype=ascii
*write pll.txt v(vo) v(vc) v(ref)
*plot v(vc)
.endc

*.op
.end
