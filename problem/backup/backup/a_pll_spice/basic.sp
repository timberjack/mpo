.SUBCKT inv vdd vss out0 in0 
mxt0  out0 in0 vss vss  nfet  l=1e-07 w=0.9u                             
mxt1  out0 in0 vdd vdd  pfet  l=1e-07 w=2.5u                             
.ENDS


.SUBCKT tristateinv vdd vss out in en 
m0 1 in vdd vdd pfet l=1e-07 w=0.28u
m1 out1 en 1 vdd pfet l=1e-07 w=0.28u
m2 out1 enb 2 vss nfet l=1e-07 w=0.12u 
m3 2 in vss vss nfet l=1e-07 w=0.12u 
minvp enb en vdd vdd pfet l=1e-07 w=0.28u
minvn enb en vss vss nfet l=1e-07 w=0.12u
m4 3 out1 vdd vdd pfet l=1e-07 w=0.28u
m5 out en 3 vdd pfet l=1e-07 w=0.28u
m6 out enb 4 vss nfet l=1e-07 w=0.12u 
m7 4 out1 vss vss nfet l=1e-07 w=0.12u
.ENDS

.SUBCKT nor2 vdd vss out a b
MT3     vss     b       out    vss nfet l=1e-07 w=1u
MT2     out     a       vss    vss nfet l=1e-07 w=1u
MT1     out     b       net14  vdd pfet l=1e-07 w=6u
MT0     net14   a       vdd    vdd pfet l=1e-07 w=6u
.ENDS 

.SUBCKT or2 vdd vss out a b
xnor2 vdd vss out1 a b  nor2
xinv vdd vss out out1  inv
.ENDS

.SUBCKT nand2 vdd vss out0 in0 in1 
mxt0  inta in1 vss vss  nfet l=1e-07 w=0.2u
mxt1  out0 in0 inta vss  nfet l=1e-07 w=0.2u
mxt2  out0 in1 vdd vdd  pfet l=1e-07 w=0.24u
mxt3  out0 in0 vdd vdd  pfet l=1e-07 w=0.24u
.ENDS

.SUBCKT and2 vdd vss out a b 
xnand2 vdd vss out1 a b  nand2
xinv vdd vss out out1  inv
.ENDS

.SUBCKT nand3 vdd vss out0 in1 in2 in3
mxtn1  inta1 in3 vss vss  nfet l=1.2e-07 w=wn_nand3
mxtn2  inta2 in2 inta1 vss  nfet l=1.2e-07 w=wn_nand3
mxtn3  out0 in1 inta2 vss  nfet l=1.2e-07 w=wn_nand3
mxtp1  out0 in1 vdd vdd  pfet l=1.2e-07 w=wp_nand3
mxtp2  out0 in2 vdd vdd  pfet l=1.2e-07 w=wp_nand3
mxtp3  out0 in3 vdd vdd  pfet l=1.2e-07 w=wp_nand3
.param wn_nand3=0.3u
.param wp_nand3=0.36u
.ENDS

.SUBCKT jkff3 vdd vss q qb j k clk
xdff vdd vss q qb d clk vss  dff3
xnand21 vdd vss j1 qb j  nand2
xnand22 vdd vss d j1 k1  nand2
xinv2 vdd vss kb k  inv
xnand23 vdd vss k1 q kb  nand2
.ENDS

.SUBCKT jkff_min vdd vss q qb j k clk
xdff vdd vss q qb d clk vss  dff3
xnand21 vdd vss j1 qb j  nand2_min
xnand22 vdd vss d j1 k1  nand2_min
xinv2 vdd vss kb k  inv_min
xnand23 vdd vss k1 q kb  nand2_min
.ENDS

.SUBCKT dff vdd vss ck q reset
xnor21  vdd vss 1  ck q  nor2
xnor22  vdd vss q  1  2  nor2    
xnor23  vdd vss 2  1  3  nor2    
xnor24  vdd vss 3  2  reset  nor2  
.ENDS

.subckt inv_min vdd vss out in
mxt0  out in vss vss  nfet  l=1.2e-07 w=0.25u                             
mxt1  out in vdd vdd  pfet  l=1.2e-07 w=0.6u     
.ends

.subckt inv_min2 vdd vss out in
mxt0  out in vss vss  nfet  l=1.2e-07 w=1u                             
mxt1  out in vdd vdd  pfet  l=1.2e-07 w=3u     
.ends

.SUBCKT nand2_min vdd vss out0 in0 in1 
mxt0  inta in1 vss vss  nfet l=1.2e-07 w=0.5u
mxt1  out0 in0 inta vss  nfet l=1.2e-07 w=0.5u
mxt2  out0 in1 vdd vdd  pfet l=1.2e-07 w=0.6u
mxt3  out0 in0 vdd vdd  pfet l=1.2e-07 w=0.6u
.ENDS

.SUBCKT and2_min vdd vss out a b 
xnand2 vdd vss out1 a b  nand2_min
xinv vdd vss out out1  inv_min
.ENDS

.SUBCKT nor2_min vdd vss out a b
MT3     vss     b       out    vss nfet l=1.2e-07 w=0.25u
MT2     out     a       vss    vss nfet l=1.2e-07 w=0.25u
MT1     out     b       net14  vdd pfet l=1.2e-07 w=0.6u
MT0     net14   a       vdd    vdd pfet l=1.2e-07 w=0.6u
.ENDS 

.SUBCKT or2_min vdd vss out a b
xnor2 vdd vss out1 a b  nor2_min
xinv vdd vss out out1  inv_min
.ENDS

.SUBCKT inv1 vdd vss out0 in0 
mxt0  out0 in0 vss vss  nfet  l=1e-07 w=3u                             
mxt1  out0 in0 vdd vdd  pfet  l=1e-07 w=9u                             
.ENDS

.SUBCKT inv2 vdd vss out0 in0 
mxt0  out0 in0 vss vss  nfet  l=1e-07 w=6u                             
mxt1  out0 in0 vdd vdd  pfet  l=1e-07 w=18u                             
.ENDS

.SUBCKT buf vdd vss out in 
xinv1 vdd vss out1 in  inv1
xinv2 vdd vss out out1  inv2
.ENDS

.SUBCKT dff3 VDD VSS q net36 d clk reset
m15     net40   net25   VSS    VSS nfet L=0.12U W=0.68U 
m16     net36   clk     net40   VSS nfet L=0.12U W=0.68U 
m20     net48   net60   net36   VSS nfet L=0.12U W=0.68U
m19     VSS    net45   net48   VSS nfet L=0.12U W=0.68U 
m23     VSS    net36   net45   VSS nfet L=0.12U W=0.68U 
m25     q       net36   VSS    VSS nfet L=0.12U W=0.68U 
m27     net60   clk     VSS    VSS nfet L=0.12U W=0.68U 
m1      VSS    reset   net8    VSS nfet L=0.12U W=0.68U 
m3      net20   net8    VSS    VSS nfet L=0.12U W=0.68U 
m4      net16   d       net20   VSS nfet L=0.12U W=0.68U 
m5      net12   net60   net16   VSS nfet L=0.12U W=0.68U 
m10     net28   clk     net12   VSS nfet L=0.12U W=0.68U 
m9      VSS    net25   net28   VSS nfet L=0.12U W=0.68U 
m13     VSS    net12   net25   VSS nfet L=0.12U W=0.68U 
m18     VDD    net25   net95   VDD pfet L=0.12U W=1.48U 
m22     net95   clk     VDD    VDD pfet L=0.12U W=1.48U 
m17     net36   net60   net95   VDD pfet L=0.12U W=1.48U
m21     net95   net45   net36   VDD pfet L=0.12U W=1.48U 
m24     VDD    net36   net45   VDD pfet L=0.12U W=1.48U 
m26     q       net36   VDD    VDD pfet L=0.12U W=1.48U 
m28     net60   clk     VDD    VDD pfet L=0.12U W=1.48U 
m2      VDD    reset   net8    VDD pfet L=0.12U W=1.48U 
m8      net68   net8    VDD    VDD pfet L=0.12U W=1.48U 
m7      VDD    d       net68   VDD pfet L=0.12U W=1.48U 
m12     net68   net60   VDD    VDD pfet L=0.12U W=1.48U 
m6      net12   clk     net68   VDD pfet L=0.12U W=1.48U 
m11     net68   net25   net12   VDD pfet L=0.12U W=1.48U
m14     VDD    net12   net25   VDD pfet L=0.12U W=1.48U 
.ENDS


.subckt buf_min vdd vss out in
xinv1 vdd vss outs1 in  inv_min
xinv2 vdd vss out outs1  inv_min
.ends

.subckt buf_min2 vdd vss out in
xinv1 vdd vss outs1 in  inv_min2
xinv2 vdd vss out outs1  inv_min2
.ends

.subckt xor vdd vss out a b 
x1 vdd vss 1 a b  nand2_min
x2 vdd vss 2 a 1  nand2_min
x3 vdd vss 3 b 1  nand2_min
x4 vdd vss out 2 3  nand2_min
.ends

.subckt one_bit_comparator vdd vss great less equal a b
x1 vdd vss ab a  inv_min
x2 vdd vss bb b  inv_min
x3 vdd vss less ab b  and2_min
x4 vdd vss great bb a  and2_min
x5 vdd vss equal less great  nor2_min
.ends
