CC = gcc
INC = ../headers

CFLAGS += $(FLAGI)

prog1: rkw.o ../lib/libusux.a
	$(CC) $(CFLAGS) ../lib/libusux.a rkw.o -L../lib -lusux -lm -o prog1 

rkw.o: rkw.c $(INC)/rkw.h
	$(CC) -c $(CFLAGS) rkw.c
	
clean:
	rm *.o
