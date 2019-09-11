#na podstawie
#  https://www.gnu.org/software/make/manual/make.html#Recursion
#  https://stackoverflow.com/questions/1139271/makefiles-with-source-files-in-different-directories

.PHONY: clean install

export FLAGI = -I../headers

all: lib/libusux.a
	$(MAKE) -C src1
	$(MAKE) -C src2

lib/libusux.a:
	$(MAKE) -C lib

clean:
	$(MAKE) -C lib clean
	$(MAKE) -C src1 clean
	$(MAKE) -C src2 clean

install:
	mkdir bin
	cp src1/prog1 ./bin
	cp src2/prog2 ./bin
