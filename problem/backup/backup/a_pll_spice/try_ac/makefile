PROG = test_BASK
#$(PROG_OBJS) = bask_modulation.o demod_bask.o
CC = g++
FLAGS = -Wall -DSC_INCLUDE_FX -O3  -lm
INCL	= -I$(AMS)/include -I$(SC)/include
OBJS	= $(AMS_OBJ)/*/*.o $(AMS_OBJ)/*/*/*.o $(AMS_OBJ)/*/*/*/*.o $(SC_OBJ)/*/*.o $(SC_OBJ)/*/*/*.o 

SC     = /usr/local/systemc-2.2.0
SC_OBJ = /home/tim/SystemC/systemc-2.2.0/objdir/src/sysc
AMS   = /home/tim/SystemC/systemc-ams-1.0BETA1
AMS_OBJ = /home/tim/SystemC/systemc-ams-1.0BETA1/objdir/src/scams/impl

all: $(PROG)

bask_modulation.o: bask_modulation.cpp
	$(CC)  -c $(FLAGS) $(INCL) $(OBJS) bask_modulation.cpp

demod_bask.o: demod_bask.cpp
	$(CC)  -c $(FLAGS) $(INCL) $(OBJS) demod_bask.cpp

BASK.o: BASK.cpp bask_modulation.o demod_bask.o
	$(CC)  -c $(FLAGS) $(INCL) $(OBJS) bask_modulation.o demod_bask.o BASK.cpp
	
$(PROG): test_BASK.cpp bask_modulation.o demod_bask.o BASK.o
	$(CC)  $(FLAGS) $(INCL) $(OBJS) bask_modulation.o demod_bask.o BASK.o test_BASK.cpp -o $(PROG)

# g++
# -Wall -DSC_INCLUDE_FX -O3  -lm
# -I$AMS/include -I$SC/include
# $AMS_OBJ/*/*.o $AMS_OBJ/*/*/*.o $AMS_OBJ/*/*/*/*.o $SC_OBJ/*/*.o $SC_OBJ/*/*/*.o $SC_OBJ/*/*/*/*.o
# bask_modulation.cpp -o bask_modulation 
