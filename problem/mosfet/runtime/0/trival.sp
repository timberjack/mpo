$level 13 mosfet optimization
$..tighten the simulator convergence properties
.OPTION nomod post=2
+       newtol relmos=1e-5 absmos=1e-8
.MODEL optmod OPT itropt=30
vds  30 0  vds
vgs  20 0  vgs
vbs  40 0  vbs
m1 30 20 0 40 nch w=50u l=4u
$..
$..process skew parameters for this data
.PARAM xwn=-0.3u xln=-0.1u toxn=196.6 rshn=67
$..the model and initial guess
.MODEL nch NMOS level=13
+  acm=2 ldif=0 hdif=4u tlev=1 n=2 capop=4 meto=0.08u xqc=0.4
$...parameters obtained from measurements
+  wd=0.15u ld=0.07u js=1.5e-04 jsw=1.8e-09
+  cj=1.7e-04 cjsw=3.8e-10
$...parameters not used for this data
+  k2=0 eta0=0 x2e=0 x3e=0  x2u1=0 x2ms=0 x2u0=0 x3u1=0
$...process skew parameters+  toxm=toxn rsh=rshn
+  xw=xwn xl=xln
$...optimized parameters
+   vfb0=-0.11 k1=0.62 x2m=4.92 muz=876 u00=0.352
+   mus=601 x3ms=36.04 u1=0.241
$...impact ionization parameters
+   alpha=1 vcr=15

*.PARAM
*+ vfb0    = opt1(-0.5, -2, 1)
*+ k1      = opt1(0.6,0.3,1)
*+ muz     = opt1(600,300,1500)
*+ x2m     = opt1(0,-10,10)
*+ u00     = opt1(0.1,0,0.5)
*+ mus     = opt2(700,300,1500)
*+ x3ms    = opt2(5,0,50)
*+ u1      = opt2(0.1,0,1)
*+ alpha   = opt2(1,1e-3,10)

.MEAS DC comp1 ERR1 par(ids) i(m1) minval=1e-04 ignor=1e-05
.MEAS DC comp2 ERR1 par(ids) i(m1) minval=1e-04 ignor=1e-05

.DC DATA=gate
.DC DATA=drain

.PRINT DC vds=par(vds) vgs=par(vgs) im=i(m1) id=par(ids)
.PRINT DC vds=par(vds) vgs=par(vgs) im=i(m1) id=par(ids)

$..data
.PARAM vds=0 vgs=0 vbs=0 ids=0
.DATA gate vds vgs vbs ids
1.000000e-01 1.000000e+00  0.000000e+00 1.655500e-05
1.000000e-01 5.000000e+00 -2.000000e+00 3.149500e-04
.ENDDATA
.DATA drain vds vgs vbs ids
2.500000e-01 2.000000e+00 0.000000e+00 2.809000e-04
5.000000e+00 5.000000e+00 0.000000e+00 4.861000e-03
.ENDDATA
.END








