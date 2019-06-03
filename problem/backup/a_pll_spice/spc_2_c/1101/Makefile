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

run_spv2.o: run_spv2.cpp
	$(CC)  -c $(FLAGS) $(INCL) run_spv2.cpp

vco.o: vco.cpp
	$(CC)  -c $(FLAGS) $(INCL) vco.cpp

$(PROG): test_vco.cpp run_spv2.o vco.o
	$(CC)  $(FLAGS) $(INCL) $(OBJS) run_spv2.o vco.o test_vco.cpp -o $(PROG)
