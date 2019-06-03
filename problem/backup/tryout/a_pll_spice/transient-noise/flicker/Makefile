PROG = simu_1-f

CC = g++
FLAGS = -Wall -DSC_INCLUDE_FX -O3  -lm
SC     = /usr/local/systemc-2.2.0
SC_OBJ = /home/tim/SystemC/systemc-2.2.0/objdir/src/sysc
AMS   = /home/tim/SystemC/systemc-ams-1.0Beta2
AMS_OBJ = /home/tim/SystemC/systemc-ams-1.0Beta2/src/scams/impl
INCL	= -I$(AMS)/include -I$(SC)/include
OBJS	= $(AMS_OBJ)/*/*.o $(AMS_OBJ)/*/*/*.o $(AMS_OBJ)/*/*/*/*.o $(SC_OBJ)/*/*.o $(SC_OBJ)/*/*/*.o

all: $(PROG)

flicker.o: flicker.cpp
	$(CC)  -c $(FLAGS) $(INCL) flicker.cpp

$(PROG): test_flicker.cpp flicker.o
	$(CC)  $(FLAGS) $(INCL) $(OBJS) flicker.o test_flicker.cpp -o $(PROG)
