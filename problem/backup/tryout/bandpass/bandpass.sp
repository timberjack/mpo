*Chebyshev Band Pass Filter

*** *** FILTER CIRCUIT *** ***
C1 1 0 #C1#  $ #CSMD_50p80p#
L1 1 0 #L1#  $ #LBOND_350p450p#

L2 1 2 #L2#  $ #LBOND_60n100n#
C2 2 3 #C2#  $ #CSMD_300f340f#

C3 3 0 #C3#  $ #CSMD_50p80p#
L3 3 0 #L3#  $ #LBOND_350p450p#


*** ***      *** ***
VIN IN 0 ac 1
RG  IN 1 1n

*** *** ANALYSIS *** ***
.AC DEC 1000 800e6 1200E6
.NET v(3) VIN rout=50 rin=50
.PROBE AC s11(db) s21(db)
.OPTION POST PROBE
.END

.MEASURE AC left_side_lobe max S21(db) from=800e6 to=900e6
.MEASURE AC pass_band_ripple min S21(db) from=960e6 to=1040e6
.MEASURE AC right_side_lobe max S21(db) from=1100e6 to=1200e6
.MEASURE AC S11_In_Band MAX S11(db) from=960e6 to=1040e6
