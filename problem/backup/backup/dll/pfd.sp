.subckt chargepump vdd vss up dn out 
Ibias vdd 1 30u
m1 1   1  vss vss nfet  w=1.8u l=1.2u
m2 2   1  vss vss nfet  w=1.8u l=1.2u
m3 2   2  vdd vdd pfet  w=1.8u l=1.2u
m4 p   2  vdd vdd pfet  w=3.6u l=1.2u
m5 out up p   vdd pfet  w=3.6u l=1.2u
m6 out dn n   vss nfet  w=3.6u l=1.2u
m7 n   1  vss vss nfet  w=3.6u l=1.2u
rout out rc  10k
c1   rc  vss 60p
c2   out vss 10p
.ends



.subckt pfd vdd vss up dn ref osc
xdffup vdd vss ref    up reset dff 
xdffdn vdd vss osc    dn reset dff 
xnand2 vdd vss resetb dn up    nand2
xinv   vdd vss reset  resetb   inv
.ends


.SUBCKT dff vdd vss ck q reset
xnor21  vdd vss n1 ck q 	nor2
xnor22  vdd vss q  n1 n2 	nor2    
xnor23  vdd vss n2 n1 n3 	nor2    
xnor24  vdd vss n3 n2 reset nor2  
.ENDS

.SUBCKT nor2 vdd vss out a b
MT1	out   b net14 vdd pfet  w=14.4u l=0.3u
MT0	net14 a vdd   vdd pfet  w=14.4u l=0.3u
MT3	vss   b out   vss nfet  w=1.8u  l=0.3u
MT2	out   a vss   vss nfet  w=1.8u  l=0.3u
.ENDS

.SUBCKT nand2 vdd vss out0 in0 in1
mxt2  out0 in1 vdd  vdd  pfet  w=3.6u l=0.3u
mxt3  out0 in0 vdd  vdd  pfet  w=3.6u l=0.3u
mxt0  inta in1 vss  vss  nfet  w=3.6u l=0.3u
mxt1  out0 in0 inta vss  nfet  w=3.6u l=0.3u
.ENDS

.SUBCKT inv vdd vss out0 in0 
mxt1  out0 in0 vdd vdd  pfet  w=3.6u l=0.3u
mxt0  out0 in0 vss vss  nfet  w=1.8u l=0.3u
.ends
