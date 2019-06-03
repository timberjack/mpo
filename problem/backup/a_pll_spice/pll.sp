.subckt vcdl_inv vdd vss out in vc
mp out in vdd vdd pfet l=2u w=4u
mn out in c vss nfet l=1.6u w=1.6u
mc c vc vss vss nfet l=1.6u w=1.6u
.ends

.subckt vcdl vdd vss out in vc
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
x15 vdd vss out in14 vc  vcdl_inv
.ends

.subckt chargepump vdd vss up dn out 
Ibias vdd 1 20u
m1 1 1 vss vss nfet l=120n w=1u
m2 2 1 vss vss nfet l=120n w=1u
m3 2 2 vdd vdd pfet l=120n w=1u
m4 p 2 vdd vdd pfet l=120n w=2u
m5 out up p vdd pfet l=120n w=2u
m6 out dn n vss nfet l=120n w=2u
m7 n 1 vss vss nfet l=120n w=2u
rout out rc 5k
c1 rc vss 144p
c2 out vss 16p
.ends
