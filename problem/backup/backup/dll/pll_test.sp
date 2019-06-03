*inverter based Oscillation PLL
** NGSPICE Simulation Options: C:\Users\Tim\Desktop\pll_test.cir
.option sim_accuracy=10
*.option sim_ac=15
.option ingold=1
.option POST=1
.option nomod
.option filetype=ascii

.include "model013.lib_inc"

.inc pfd.sp
.inc rvco.sp

*.subckt vcdl vdd vss out in vc
x100 vdd 0 osc osc vc vcdl

*.subckt pfd vdd vss up dn ref osc
x101 vdd 0 up down ref osc pfd

*.subckt inv vdd vss out in
x102 vdd 0 upb up inv

*.subckt chargepump vdd vss up dn out
x103 vdd 0 upb down vc chargepump


*Transient Analysis Test Bench
vdd vdd 0 1.2
*vcc vcc 0 0.442
*vosc osc 0 pulse (0 1.2 100n 6.25n 6.25n 25e-9 72.5e-9)
*vref ref 0 sin ( 0.6 0.6 16e6 )
vref ref 0 pulse (0 1.2 10n 6.25n 6.25n 25e-9 62.5e-9)
.ic v(osc)=1.2 v(vc)=0

.trans 1n 7u
.print v(osc) v(ref) v(up) v(down) v(vc)

.end
