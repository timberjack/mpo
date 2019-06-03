*Three stage operational amplifier

*** *** OPAMP SUBCIRCUIT *** ***
.SUBCKT PFC.SUB VP VN VOUT IBIAS VB1 AVDD AVSS

M00 IBIAS IBIAS AVDD AVDD PMOS W=#WM00_10# L=#LM1#

* differential pair
M10 1     IBIAS AVDD AVDD PMOS W=#WM00_10# L=#LM1# M=6

M11 2     VN    1    1    PMOS W=#WM11_12# L=#LM2#
M12 3     VP    1    1    PMOS W=#WM11_12# L=#LM2#

* folded cascode
M13 4     IBIAS AVDD AVDD PMOS W=#WM13_16# L=#LM1# M=3
M16 5     IBIAS AVDD AVDD PMOS W=#WM13_16# L=#LM1# M=3

M14 4     VB1   2    AVSS NMOS W=#WM14_17# L=#LM3#
M17 5     VB1   3    AVSS NMOS W=#WM14_17# L=#LM3#

M15 2     4     AVSS AVSS NMOS W=#WM15_18# L=#LM4#
M18 3     4     AVSS AVSS NMOS W=#WM15_18# L=#LM4#

* second stage
M20 6     5     AVDD AVDD PMOS W=#WM20# L=#LM6#
M22 7     IBIAS AVDD AVDD PMOS W=#WM22# L=#LM1#

M21 6     6     AVSS AVSS NMOS W=#WM21_23# L=#LM5#
M23 7     6     AVSS AVSS NMOS W=#WM21_23# L=#LM5#

* third stage
M30 VOUT  5     AVDD AVDD PMOS W=#WM30# L=#LM6# M=22
M31 VOUT  7     AVSS AVSS NMOS W=#WM31# L=#LM7# M=5

* compensation
CM1 5 VOUT #CC1#
CM2 5 7    #CC2#
.ENDS PFC.SUB

*** *** SUPPLY VOLTAGES *** ***
VDD VDD 0 #VSUPPLY#
VSS VSS 0   0

*** *** BIAS VOLTAGE *** ***
VVB1 VB1 VSS DC #VBIAS#

*** *** BIAS CURRENT *** ***
IIBIAS IBIAS VSS #IBIAS#

*** *** SUB-CIRCUIT *** ***
XOPAMP VP VN VOUT IBIAS VB1 VDD VSS PFC.SUB

*** *** LOAD *** ***
RL VOUT VX #RLOAD#
CL VOUT VX #CLOAD#
VX VX VSS '#VSUPPLY#/2'

*** *** AC LOOP *** ***
VIN VP VSS '#VSUPPLY#/2' AC 1
RX  VN VOUT 1m AC=1E12
CX  VN VSS 10

*** *** ANALYSIS *** ***
.AC DEC 100 0.001 1E9
.PZ V(VOUT) VIN
.PROBE AC VDB(VOUT)
.PROBE AC VP(VOUT)
.OP
.OPTION POST UNWRAP
.option sim_accuracy=10
.option ingold=2
.option post=2
.option putmeas=0
.INCLUDE p.typ
.INCLUDE n.typ

.MEASURE AC ac_power PARAM='-1*p(VDD)'
.MEASURE AC ZUGF WHEN VDB(VOUT)=0 CROSS=1
.MEASURE AC UGFZSR TRIG AT=1 TARG VDB(VOUT) VAL=0 FALL=1
.MEASURE AC ZSR PARAM='UGFZSR*3.14'
.MEASURE AC dc_gain FIND VDB(VOUT) AT=0.1
.MEASURE AC phaseZPM FIND VP(VOUT) WHEN VDB(VOUT)=0
.MEASURE AC ZPM1 PARAM='180+phaseZPM'
.MEASURE AC ZPM2 PARAM='180+phaseZPM'



.END
