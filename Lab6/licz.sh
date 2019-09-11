#!/bin/bash

usage="Usage: $0 [-R] katalog [typ]"

if [[ $# -lt 1 || $# -gt 3 ]]
then
    (>&2 cho "Wrong argument count!")
    (>&2 echo $usage)
    exit 1
fi

d=""
rflag=0
t=""

if [ "$1" = "-R" ]
then
    rflag=1
    shift
fi

d="$1"
shift

if [[ $1 ]] ;
then
    t="$1"
fi

if [[ ! -d "$d" ]] ;
then
    (>&2 echo "directory $d does not exist!")
    (>&2 echo $usage)
    exit 2
fi

if [[ ! -r "$d"  || ! -x "$d" ]] ;
then
    (>&2 echo "directory $d does not have r/x permissions!")
	exit 3
fi

types=( "b" "c" "d" "p" "f" "l" "s")
#b      block (buffered) special
#c      character (unbuffered) special
#d      directory
#p      named pipe (FIFO)
#f      regular file
#l      symbolic link
#s      socket

if [[ ! -z "$t" && ! " ${types[@]} " =~ " $t " ]]; then
    (>&2 echo "$t is not a valid type!")
    (>&2 echo $usage)
    exit 4
fi


count=0

if [ "$rflag" -eq 0 ]
then
    if [ -z "$t" ]
    then
        # all types, no rec
	    count=$(find "$d" -maxdepth 1 ! -name '.' ! -name '..' | awk 'END {print NR}')
    else
        # one type, no rec
	    count=$(find "$d" -maxdepth 1 ! -name '.' ! -name '..' -type "$t" | awk 'END {print NR}')
    fi
else
    if [ -z "$t" ]
    then
        # all types, rec
        count=$(find "$d" ! -name '.' ! -name '..' | awk 'END {print NR}')
    else
        count=$(find "$d" ! -name '.' ! -name '..' -type "$t" | awk 'END {print NR}')
        # one type, no rec
    fi
fi

echo "$count"

exit 0

