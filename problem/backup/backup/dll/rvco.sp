*.subckt vcdl_inv vdd vss out in vc
*mp out in vdd vdd pfet l=2u   w=4u
*mn out in c   vss nfet l=1.6u w=1.6u
*mc c   vc vss vss nfet l=1.6u w=1.6u
*.ends

.subckt vcdl_inv vdd vss out in vc
mp out in vdd vdd pfet  w=7.2u l=2.4u
mn out in c   vss nfet  w=6.4u l=2.0u
mc c   vc vss vss nfet  w=6.4u l=2.0u
.ends

.subckt vcdl vdd vss out in vc
x1  vdd vss in1  in  vc		vcdl_inv
x2  vdd vss in2  in1 vc		vcdl_inv
x3  vdd vss in3  in2 vc		vcdl_inv
x4  vdd vss in4  in3 vc		vcdl_inv
x5  vdd vss in5  in4 vc		vcdl_inv
x6  vdd vss in6  in5 vc		vcdl_inv
x7  vdd vss in7  in6 vc		vcdl_inv
x8  vdd vss in8  in7 vc		vcdl_inv
x9  vdd vss out  in8 vc		vcdl_inv
*x9  vdd vss in9  in8 vc	vcdl_inv
*x10 vdd vss in10 in9 vc	vcdl_inv
*x11 vdd vss in11 in10 vc	vcdl_inv
*x12 vdd vss in12 in11 vc	vcdl_inv
*x13 vdd vss in13 in12 vc	vcdl_inv
*x14 vdd vss in14 in13 vc	vcdl_inv
*x15 vdd vss out  in14 vc	vcdl_inv
*x15 vdd vss in15 in14 vc / vcdl_inv
*x16 vdd vss in16 in15 vc / vcdl_inv
*x17 vdd vss out  in16 vc / vcdl_inv
.ends
