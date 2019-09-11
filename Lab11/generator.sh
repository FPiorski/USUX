#!/bin/bash

usage="$0 katalog"

if ! [[ -d $1 ]];
then
    echo "$usage"
    exit 1
fi

cd "$1"

for f in *.c
do
    if  egrep -q 'main\s?\(' $f;
    then
        main=$(basename $f .c)
    fi
done

#echo cflags, etc.

echo "all: $main"                                  > Makefile
echo ""                                           >> Makefile
echo ".PHONY: clean"                              >> Makefile
echo "CC = gcc"                                   >> Makefile
echo "LDFLAGS = -lm"                              >> Makefile
echo "CFLAGS  = -std=c11 -Wall -Wextra -Iheaders" >> Makefile
echo ""                                           >> Makefile

echo -n "$main:" >> Makefile

for f in *.c
do
    echo -n " $f" | sed -e 's/\.c/.o/' >> Makefile
done
echo -e "" >> Makefile
echo -ne '\t$(CC) -o' "$main" '$(CFLAGS) $(LDFLAGS)' >> Makefile
for f in *.c
do
    echo -n " $f" | sed -e 's/\.c/.o/' >> Makefile
done
echo -e "\n" >> Makefile

for f in *.c
do
    echo -n "$f $f " | sed -e 's/\.c/.o:/' >> Makefile
    egrep -o '#include ".*"' $f | sed -e 's,#include ",headers/,g;s/"//g' | tr '\n' ' ' >> Makefile
    echo -e "" >> Makefile
    echo -ne '\t$(CC) -c' "$f" '$(CFLAGS)' >> Makefile
    echo -e "\n" >> Makefile
done

echo -e 'clean:\n\trm -f *.o' >> Makefile
