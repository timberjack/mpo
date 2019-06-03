PROG = simu_vco

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

vco.o: vco.h vco.cpp
	$(CC)  -c $(FLAGS) $(INCL) vco.cpp

interface.o: interface.h interface.cpp
	$(CC)  -c $(FLAGS) $(INCL) interface.cpp

call_spice.o: call_spice.h call_spice.cpp
	$(CC)  -c $(FLAGS) $(INCL) call_spice.cpp

$(PROG): test_vco.cpp vco.o interface.o call_spice.o
	$(CC)  $(FLAGS) $(INCL) $(OBJS) vco.o interface.o call_spice.o test_vco.cpp -o $(PROG)
