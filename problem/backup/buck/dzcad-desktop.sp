
.subckt INV vss in out vdd
m0 out in vdd vdd PMOS l=350e-9 w=1.5e-6
m1 out in vss vss NMOS l=350e-9 w=700e-9
.ends INV
.subckt NAND a b vss out vdd
m2 out a vdd vdd PMOS l=350e-9 w=1.5e-6
m3 out b vdd vdd PMOS l=350e-9 w=1.5e-6
m1 out a net17 vss NMOS l=350e-9 w=1.4e-6
m0 net17 b vss vss NMOS l=350e-9 w=1.4e-6
.ends NAND
.subckt NOR a b vss out vdd
m2 net17 a vdd vdd PMOS l=350e-9 w=3.0e-6
m3 out b net17 vdd PMOS l=350e-9 w=3.0e-6
m0 out a vss vss NMOS l=350e-9 w=700e-9
m1 out b vss vss NMOS l=350e-9 w=700e-9
.ends NOR
.subckt AND a b vss out vdd
xi3 vss net14 out vdd INV
xi2 a b vss net14 vdd NAND
.ends AND
.subckt OR a b vss out vdd
xi3 vss net8 out vdd INV
xi2 a b vss net8 vdd NOR
.ends OR
.subckt INV_L vss in out vdd
m1 out in vdd vdd PMOS l=350e-9 w=4.4e-6
m0 out in vss vss NMOS l=350e-9 w=2.0e-6
.ends INV_L
.subckt rs vss q reset set vdd
xi4 net7 net21 vss net11 vdd NAND
xi3 net25 net11 vss net7 vdd NAND
xi2 vss net11 q vdd INV_L
xi0 vss set net25 vdd INV
xi1 vss reset net21 vdd INV
.ends rs
.subckt cmp vss ibn out vdd _net0 _net1
xi13 vss net48 net37 vdd INV
xi14 vss net37 out   vdd INV_L
m3 net52 net52 vss   vss NMOS l=350e-9 w=2.4e-6
m4 net48 net44 vss   vss NMOS l=350e-9 w=0.6e-6
m2 net44 net52 vss   vss NMOS l=350e-9 w=2.4e-6
m5 ibn   ibn   vdd   vdd PMOS l=350e-9 w=0.9e-6
m7 net48 ibn   vdd   vdd PMOS l=350e-9 w=0.9e-6
m9 net44 _net0 net63 vdd PMOS l=350e-9 w=0.6e-6
m8 net52 _net1 net63 vdd PMOS l=350e-9 w=0.6e-6
m6 net63 ibn   vdd   vdd PMOS l=350e-9 w=6.0e-6
.ends cmp
.subckt bufferp gn vss gp sp vdd
xi7 gn sp vss net73 vdd OR
m19 gp    vdd   net99 vss NMOS l=350e-9 w=6e-6
m23 net99 net35 vss   vss NMOS l=350e-9 w=6e-6
m21 net39 net12 vss   vss NMOS l=350e-9 w=4e-6
m22 net93 net39 vss   vss NMOS l=350e-9 w=6e-6
m18 net35 vdd   net93 vss NMOS l=350e-9 w=6e-6
m20 net12 net73 vss   vss NMOS l=350e-9 w=2e-6
m15 net96 net35 vdd   vdd PMOS l=350e-9 w=12e-6
m14 net92 net39 vdd   vdd PMOS l=350e-9 w=12e-6
m13 net39 net12 vdd   vdd PMOS l=350e-9 w=8e-6
m16 net35 vss   net92 vdd PMOS l=350e-9 w=12e-6
m17 gp    vss   net96 vdd PMOS l=350e-9 w=12e-6
m12 net12 net73 vdd   vdd PMOS l=350e-9 w=4e-6
.ends bufferp
.subckt buffern gn vss gp sn vdd
xi7 gp sn vss net73 vdd AND
m19 gn    vdd   net99 vss NMOS l=350e-9 w=6e-6
m23 net99 net35 vss   vss NMOS l=350e-9 w=6e-6
m21 net39 net12 vss   vss NMOS l=350e-9 w=4e-6
m22 net93 net39 vss   vss NMOS l=350e-9 w=6e-6
m18 net35 vdd   net93 vss NMOS l=350e-9 w=6e-6
m20 net12 net73 vss   vss NMOS l=350e-9 w=2e-6
m15 net96 net35 vdd   vdd PMOS l=350e-9 w=12e-6
m14 net92 net39 vdd   vdd PMOS l=350e-9 w=12e-6
m13 net39 net12 vdd   vdd PMOS l=350e-9 w=8e-6
m16 net35 vss   net92 vdd PMOS l=350e-9 w=12e-6
m17 gn    vss   net96 vdd PMOS l=350e-9 w=12e-6
m12 net12 net73 vdd   vdd PMOS l=350e-9 w=4e-6
.ends buffern
.subckt amp2 vss ib_amp vdd _net0 _net1 vout
m8  ib_amp ib_amp vdd   vdd pmos W=3E-06 L=1E-07
m7  net8   ib_amp vdd   vdd pmos W=3E-06 L=1E-07
m1  net1   _net0  net8  vdd pmos W=3E-06 L=5E-07
m0  net5   _net1  net8  vdd pmos W=3E-06 L=5E-07
m3  net1   net1   vss   vss nmos W=8E-07 L=7.5E-07
m2  net5   net5   vss   vss nmos W=8E-07 L=7.5E-07
m9  net67  net23  vdd   vdd pmos W=2E-06 L=3E-07
m6  net23  net23  vdd   vdd pmos W=2E-06 L=3E-07
m29 vout   net52  net67 vdd pmos W=2E-06 L=3E-07
m28 net52  net52  net23 vdd pmos W=2E-06 L=3E-07
m4  net52  net5   vss   vss nmos W=1.5E-06 L=2.5E-07
m5  vout   net1   vss   vss nmos W=1.5E-06 L=2.5E-07
.ends amp2
.option sim_accuracy=10
.option ingold=1
.option POST=1
.option nomod
.option filetype=ascii
.PARAM lind=82e-6 iload_ini=0 co=0.15e-6 vref_ini=0 veao_ini=0 ccomp=0.45e-6 
.PARAM rl1=15 rl2=10
.model pmos pmos level=54 version=4.4
.model nmos nmos level=54 version=4.4
m0 vx vgp vin vin PMOS l=100e-9 w=70e-3
m1 vx vgn 0   0   NMOS l=100e-9 w=70e-3
l0 vx vo lind IC=iload_ini
c0 vo 0  co   IC=vref_ini
rload vo 0 25
xi8 0 net34 vdd net50 net80 veao amp2
r1 vo	 net80 5.000000E+03
c1 net80 veao  1.200000E-11
r2 net80 net81 3.300000E+04
c2 net81 veao  3.900000E-10
xi3 0 net32 reset vdd net12 veao cmp
xi5 0 pwm net49 reset vdd rs
xi7 vgn 0 vgp pwm vdd buffern
xi6 vgn 0 vgp pwm vdd bufferp
i1 net34 0 5.000000E-07
i4 net32 0 3.000000E-06
vin vin 0 3.3
vdd vdd 0 3.3
vref  net50 0 1.2
vramp net12 0 DC=0 PULSE  0 3.3 0      990e-9 9e-9 1e-9  1e-6
vclk  net49 0 DC=0 PULSE  0 3.3 985e-9 1e-9   1e-9 18e-9 1e-6
.tran 20n 150u
.control
run
write buck_test.tr0 v(vin) v(vx) v(vo) v(net50) v(veao) v(net12) v(reset) v(net49) v(pwm)
.endc
.MEASURE TRAN Zvo_average0 AVG vo from=120u to=150u
.MEASURE TRAN Zpeak_to_peak1 PP vo from=120u to=150u
.MEASURE TRAN Zpeak_to_peak2 PP vo from=120u to=150u
.end
