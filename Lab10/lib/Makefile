CC = gcc
INC = ../headers

CFLAGS += $(FLAGI)

libusux.a: delta.o pierw.o
	ar -rv libusux.a delta.o pierw.o

delta.o: delta.c $(INC)/fun.h
	$(CC) -c $(CFLAGS) delta.c
	
pierw.o: pierw.c $(INC)/fun.h
	$(CC) -c $(CFLAGS) pierw.c

clean:
	rm *.o
