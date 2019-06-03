*inverter based Oscillation Frequency
** HSPICE RF Simulation Options :
.option sim_accuracy=10
.option ingold=1
.option POST=2
.option nomod

.include "model013.lib_inc"


vdd vdd 0 1.2
vss vss 0 0
vc  vc 0 0.6

.subckt vcdl_inv vdd vss out in vc
mp out in vdd vdd pfet l=2u w=4u
mn out in c vss nfet l=1.6u w=1.6u
mc c vc vss vss nfet l=1.6u w=1.6u
.ends

*.subckt vcdl vdd vss out in vc
x1 vdd vss in1 in vc / vcdl_inv
x2 vdd vss in2 in1 vc / vcdl_inv
x3 vdd vss in3 in2 vc / vcdl_inv
x4 vdd vss in4 in3 vc / vcdl_inv
x5 vdd vss in5 in4 vc / vcdl_inv
x6 vdd vss in6 in5 vc / vcdl_inv
x7 vdd vss in7 in6 vc / vcdl_inv
x8 vdd vss in8 in7 vc / vcdl_inv
x9 vdd vss in9 in8 vc / vcdl_inv
x10 vdd vss in10 in9 vc / vcdl_inv
x11 vdd vss in11 in10 vc / vcdl_inv
x12 vdd vss in12 in11 vc / vcdl_inv
x13 vdd vss in13 in12 vc / vcdl_inv
x14 vdd vss in14 in13 vc / vcdl_inv
x15 vdd vss in in14 vc / vcdl_inv
*x16 vdd vss in16 in15 vc / vcdl_inv
*x17 vdd vss in17 in16 vc / vcdl_inv
*x18 vdd vss in18 in17 vc / vcdl_inv
*x19 vdd vss in in18 vc / vcdl_inv


*.ends 

*Transient Analysis Test Bench

*stimulate oscillation with 2mA pu
*iosc in 0 PULSE ( 0 2m 10p 1p 1p 1u 2u)
.ic v(in)=1.2 v(vc)=0.7
.trans 100p 1u sweep vc 0.2 1 0.1
.print v(in) v(vc) 
.probe v(in) v(vc) 

*.option HBTRANINIT=0.05u
*.option HBTRANFREQSEARCH=1
 
*.HBOSC tones=1.3e5 nharms=10 PROBENODE=in,gnd,1
*.phasenoise dec 5 600e3 700e3 METHOD=0 CARRIERINDEX=1 
*+listsources=on listfreq=(all)

*.print phasenoise phnz
*.print hbosc vm(in) vp(in)
*.print phasenoise phnz
*.probe phasenoise phnz

.op
.END
