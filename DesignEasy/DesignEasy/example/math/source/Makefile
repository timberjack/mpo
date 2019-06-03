#
DEP_INST_PATH=${HOME}/gcc_inst/bin
CC = ${DEP_INST_PATH}/g++
CFLAGS =-O2 -DASCO -std=c++11 -g


#
all: math

math:
	$(CC) $(CFLAGS) MathTop.cpp MathTestbench.cpp -o math -lm

clean:
	rm -f math 
