CCFLAGS = -g -std=c++11 
CC	= g++
COBJS	= convert.o

convert		: $(COBJS)
		$(CC) -o $@ $(COBJS)

convert.o 	: convert.cpp
		$(CC) $(CCFLAGS) -c convert.cpp

clean		:
		rm -f *.o convert
