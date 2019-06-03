*************************************************************************
.lib 'mix025_1.l' TT  
*************************************************************************
.OP
.option sim_accuracy=10
.option ingold=2
.option post=2
*************************************************************************
.PARAM P_P = 0.1
.PARAM V_INS = '2.5'
.PARAM M2 = '#M2#'
.PARAM M3 = '#M3#'
.PARAM V_SUPPLY = '#V_SUPPLY#'
.PARAM INP_FREQ = '#INP_FREQ#'
.PARAM INP_PERIOD = '1/INP_FREQ'
.PARAM NO_PERIODS = '#NO_PERIODS#'
.PARAM TMEAS_START = '(NO_PERIODS-1)*INP_PERIOD'
.PARAM TMEAS_STOP = '(NO_PERIODS)*INP_PERIOD'
.PARAM T_PERC = 99
.PARAM TMEAS_AUX = '(NO_PERIODS-1)*INP_PERIOD \\
+                  + T_PERC/100*INP_PERIOD'
*********************ClassE amplifier**************************************
M1 n3 Vg n6 0 nch W=#W1# L=#LMIN# M=#M1#   $orginal is 150
M2 n6 n2 0 0 nch  W=#W1# L=#LMIN# M=#M1#   $orginal is 150
L2 VDD n3  #L2#  
L3 n3 n4 #L3# 
C1 n3 0    #C1#    $orginal is 37p
C2 n4 Vout #C2#    $orginal is 20p
C3 Vout 0  #C3#    $orginal is 14p
RL Vout 0 50
*****************************************driver******************************
M3 n2 n0 VDD1 VDD1 pch W=100u L=0.25u m=M2	$orginal is 20
M4 n2 n1 0 0 nch W=100u L=0.25u m=M3		$orginal is 8
C00 Vin n0 #C0#					$orginal is 3p
C01 Vin n1 #C0#
R00 VDD1 n0 #R0#				$orginal is 500
R01 n1  0  #R0#
L1  n2 n7 #L0# $ 			
$orginal is 2n
Cc  n7 0  #CC#					$orginal is 5p
******************************************************************************
VDD VDD 0 V_SUPPLY
VDD1 VDD1 0 2.5
Vg Vg 0 2.5
VIN VIN 0 SIN (0 2.5 900MEG 1ns)
+ POWER=1
+ HB P_P 0.0 1 1 
******************************************************************************
.TRAN 'INP_PERIOD/1000' '(NO_PERIODS+1)*INP_PERIOD'
.hb tones=900E6 nharms=10 
.measure tran Pdc rms par('i(VDD)*V_SUPPLY') from=tmeas_start to=tmeas_stop
.measure HB Pout PARAM=' P(RL)[1]'
.end
