*Power Supplies
Vdd 1 0 DC +5V
Vbb 2 0 DC -2V
*Input Signal
*Vin 3 0 PWL 0ns 0V 0.4ns 5V 14.6ns 5V 0.4ns 0V
Vin 3 0 PULSE (0 5 0n 0.4n 0.4n 14.6n 30n)
*Inverter Circuit
M1 4 3 0 2 NENH L=2u W=4u AD=32p
M2 1 4 4 2 NDEP L=4u W=2u AS=32p
Cout 4 0 0.1pf
*Vout 4 0
*Include statement to obtain MOS model file 
.INCLUDE "n.typ"
*For Voltage Transfer Characteristic (VTC) 
.DC Vin 0 5 0.1 
.PROBE DC V(4) 
*For propagation delay and power 
.TRAN 0.1ns 60ns
*For propagation delay
.PROBE TRAN V(3) V(4)
*For average power over one full Vin cycle
.MEAS TRAN avgpow AVG POWER FROM=30n TO=60n
.OPTIONS PROBE POST MEASOUT
.END
