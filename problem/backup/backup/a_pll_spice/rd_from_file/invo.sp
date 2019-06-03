*inverter based Oscillation Frequency
** HSPICE RF Simulation Options :
.option sim_accuracy=10		*simulation data accuracy
.option ingold=1			*science math. record (x.y*10ez)
.option POST=2				*control output ?
.option nomod				*not listing process file in data output file
.option filetype=ascii

.inc "model013.lib_inc"

vdd vdd 0 1.2
vss vss 0 0
*vc  vc 0 0.6
vc vc 0 PWL (step_val vcval)
.tran DATA = tstep_val
.include "vc_sysC.txt"
*.include "invo_sysC.txt"
*.include "invo_SPICE.txt"
*.include "vc.txt"


.subckt vcdl_inv vdd vss out in v_c
mp out in vdd vdd pfet l=2u w=4u	$ name drain gate source bulk device length width
mn out in cn vss nfet l=1.6u w=1.6u
mc cn v_c vss vss nfet l=1.6u w=1.6u
.ends

*.subckt vcdl_inv vdd vss out in v_c
x1 vdd vss in1 in vc  vcdl_inv
x2 vdd vss in2 in1 vc  vcdl_inv
x3 vdd vss in3 in2 vc  vcdl_inv
x4 vdd vss in4 in3 vc  vcdl_inv
x5 vdd vss in5 in4 vc  vcdl_inv
x6 vdd vss in6 in5 vc  vcdl_inv
x7 vdd vss in7 in6 vc  vcdl_inv
x8 vdd vss in8 in7 vc  vcdl_inv
x9 vdd vss in9 in8 vc  vcdl_inv
x10 vdd vss in10 in9 vc  vcdl_inv
x11 vdd vss in11 in10 vc  vcdl_inv
x12 vdd vss in12 in11 vc  vcdl_inv
x13 vdd vss in13 in12 vc  vcdl_inv
x14 vdd vss in14 in13 vc  vcdl_inv
x15 vdd vss in in14 vc  vcdl_inv
*x16 vdd vss in16 in15 vc  vcdl_inv
*x17 vdd vss in17 in16 vc  vcdl_inv
*x18 vdd vss in18 in17 vc  vcdl_inv
*x19 vdd vss in in18 vc  vcdl_inv


*Transient Analysis Test Bench	$stimulate oscillation with 2mA pu
.ic v(in)=0 v(vc)=0.6
*.tran 100p 2u
*.dc vc 0.2 1.0 0.4

*.load "pll_spice_vc.txt"
*.load "pll_sysC_vc.txt"
*.probe v(in) v(vc)
.save v(in) v(vc)
*.save @m.x3.mp[id]

*.control
*run
*set filetype=ascii
*write invo.txt v(in) v(vc)
*plot v(in) v(vc)
*plot (-1)*i(vdd)
*.endc

.END