.subckt pfd vdd vss up dn ref fb
xdffup vdd vss ref up reset  dff 
xdffdn vdd vss fb dn reset  dff 
xnand2 vdd vss resetb dn up  nand2
xinv   vdd vss reset resetb  inv
.ends 
