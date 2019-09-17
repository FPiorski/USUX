all: prog

.PHONY: clean

CC = gcc
LDFLAGS = -lm
INC = include
CFLAGS  = -std=c11 -Wall -Wextra -I$(INC)

prog: rkw.o libusux.a
	$(CC) -o prog rkw.o libusux.a $(CFLAGS) $(LDFLAGS)

libusux.a: delta.o pierw.o
	ar -rv libusux.a delta.o pierw.o

pierw.o: pierw.c $(INC)/fun.h
	$(CC) -c pierw.c $(CFLAGS)

rkw.o: rkw.c $(INC)/rkw.h
	$(CC) -c rkw.c $(CFLAGS)

delta.o: delta.c $(INC)/fun.h
	$(CC) -c delta.c $(CFLAGS)

clean:
	rm -f *.o
