*inverter based Oscillator
** NGSPICE Simulation Options: C:\Users\Tim\Desktop\rvco_test.cir
.option sim_accuracy=10
*.option sim_ac=15
.option ingold=1
.option POST=1
.option nomod
.option filetype=ascii

.include "model013.lib_inc"

.subckt vcdl_inv vdd vss out in vc
mp out in vdd vdd pfet  w=7.2u l=2.4u
mn out in c   vss nfet  w=6.4u l=2.0u
mc c   vc vss vss nfet  w=6.4u l=2.0u
.ends

x1 vdd 0 in1  in  vc   vcdl_inv
x2 vdd 0 in2  in1 vc   vcdl_inv
x3 vdd 0 in3  in2 vc   vcdl_inv
x4 vdd 0 in4  in3 vc   vcdl_inv
x5 vdd 0 in5  in4 vc   vcdl_inv
x6 vdd 0 in6  in5 vc   vcdl_inv
x7 vdd 0 in7  in6 vc   vcdl_inv
x8 vdd 0 in8  in7 vc   vcdl_inv
x9 vdd 0 in   in8 vc   vcdl_inv

*Transient Analysis Test Bench
vdd vdd 0 1.2
vc  vc  0 1.1
.ic v(in)=0

.trans 1n 0.2u
.print v(in) v(vc)

.end

