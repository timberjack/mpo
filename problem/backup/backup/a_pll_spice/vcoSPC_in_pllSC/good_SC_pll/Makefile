PROG = simu_pll

CC = g++
FLAGS = -Wall -DSC_INCLUDE_FX -O3  -lm
SC     = /usr/local/systemc-2.2.0
SC_OBJ = /home/tim/SystemC/systemc-2.2.0/objdir/src/sysc
AMS   = /home/tim/SystemC/systemc-ams-1.0Beta2
AMS_OBJ = /home/tim/SystemC/systemc-ams-1.0Beta2/src/scams/impl
INCL	= -I$(AMS)/include -I$(SC)/include
OBJS	= $(AMS_OBJ)/*/*.o $(AMS_OBJ)/*/*/*.o $(AMS_OBJ)/*/*/*/*.o $(SC_OBJ)/*/*.o $(SC_OBJ)/*/*/*.o

all: $(PROG)

#g++ run_spv2.cpp -o run_spv2.o

clk.o: clk.h clk.cpp
	$(CC)  -c $(FLAGS) $(INCL) clk.cpp

PFD.o: PFD.h PFD.cpp
	$(CC)  -c $(FLAGS) $(INCL) PFD.cpp

pll_lpf.o: pll_lpf.cpp
	$(CC)  -c $(FLAGS) $(INCL) pll_lpf.cpp

vco.o: vco.h vco.cpp
	$(CC)  -c $(FLAGS) $(INCL) vco.cpp

#interface.o: interface.h interface.cpp run_spv2.cpp
#	$(CC)  -c $(FLAGS) $(INCL) interface.cpp

$(PROG): test_pll.cpp clk.o PFD.o pll_lpf.o vco.o
	$(CC)  $(FLAGS) $(INCL) $(OBJS) clk.o PFD.o pll_lpf.o vco.o test_pll.cpp -o $(PROG)

#$(PROG): test_pll.cpp clk.o PFD.o pll_lpf.o interface.o
#	$(CC)  $(FLAGS) $(INCL) $(OBJS) clk.o PFD.o pll_lpf.o interface.o test_pll.cpp -o $(PROG)
