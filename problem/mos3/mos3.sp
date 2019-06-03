$level 3 mosfet optimization
$..tighten the simulator convergence properties
.OPTION nomod post=2 newtol relmos=1e-5 absmos=1e-8
.MODEL optmod OPT itropt=30

vds  30 0  vds
vgs  20 0  vgs
vbs  40 0  vbs
m1 30 20 0 40 nch w=50u l=4u
$..
$..process skew parameters for this data

.PARAM xwn=-0.3u xln=-0.1u toxn=196.6 rshn=67
$..the model and initial guess
.MODEL nch NMOS level=3
+  acm=2 ldif=0 hdif=4u tlev=1 n=2
+  capop=4 meto=0.08u xqc=0.4

$...note capop=4 is ok for H8907 and later, otherwise use
$...Capop=2
$...fixed parameters
+  wd=0.15u ld=0.07u
+  js=1.5e-04 jsw=1.8e-09
+  cj=1.7e-04 cjsw=3.8e-10
+  nfs=2e11 xj=0.1u  delta=0  eta=0
$...process skew parameters
+  tox=toxn rsh=rshn
+  xw=xwn xl=xln

+ vto=#vto# gamma=#gamma#
+ uo=#uo#  vmax=#vmax# theta=#theta# kappa=#kappa#

*.PARAM
*+ vto    = opt1(1,0.5,2)
*+ gamma  = opt1(0.8,0.1,2)
*+ uo     = opt1(480,400,1000)
*+ vmax   = opt1(2e5,5e4,5e7)
*+ theta  = opt1(0.05,1e-3,1)
*+ kappa  = opt1(2,1e-2,5)

*.DC DATA=all  optimize=opt1  results=comp1  model=optmod
.MEAS DC comp1 ERR1 par(ids) i(m1) minval=1e-04 ignor=1e-05

.DC DATA=gate
.DC DATA=drain

.PRINT DC vds=par(vds) vgs=par(vgs) im=i(m1) id=par(ids)
.PRINT DC vds=par(vds) vgs=par(vgs) im=i(m1) id=par(ids)

$..data
.PARAM vds=0 vgs=0 vbs=0 ids=0
.DATA all vds vgs vbs ids
1.000000e-01 1.000000e+00  0.000000e+00 1.655500e-05
5.000000e+00 5.000000e+00 0.000000e+00 4.861000e-03
.ENDATA
.DATA gate vds vgs vbs ids
1.000000e-01 1.000000e+00  0.000000e+00 1.655500e-05
1.000000e-01 5.000000e+00 -2.000000e+00 3.149500e-04
.ENDDATA
.DATA drain vds vgs vbs ids
2.500000e-01 2.000000e+00 0.000000e+00 2.302000e-04
5.000000e+00 5.000000e+00 0.000000e+00 4.861000e-03
.ENDDATA
.END
