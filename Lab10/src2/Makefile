CC = gcc
INC = ../headers

CFLAGS += $(FLAGI)

prog2: rlin.o input.o ../lib/libusux.a
	$(CC) -L../lib -lusux -lm -o prog2 $(CFLAGS) ../lib/libusux.a rlin.o input.o

rlin.o: rlin.c $(INC)/rlin.h
	$(CC) -c $(CFLAGS) rlin.c

input.o: input.c $(INC)/rlin.h
	$(CC) -c $(CFLAGS) input.c
	
clean:
	rm *.o
