#!/bin/bash

usage="Usage: $0 [-a]  plik  [kolumna1 kolumna2 ...]"

if [[ $# -lt 1 ]] ;
then
    (>&2 echo "Wrong argument count!")
    (>&2 echo $usage)
    exit 1
fi

aflag=0

if [ "$1" = "-a" ]
then
    aflag=1
    shift
fi

plik="$1"
shift

if [[ ! -f "$plik" ]] ;
then 
    (>&2 echo "Input file does not exist!")
    (>&2 echo $usage)
    exit 2
fi

if [[ ! -r "$plik" ]] ;
then 
    (>&2 echo "Input file cannot be read!")
    (>&2 echo $usage)
    exit 3
fi

for i in "$@"
do
    if ! [ "$i" -eq "$i" 2>/dev/null ]
    then
        (>&2 echo "Column numbers must be actual integer numbers")
        (>&2 echo $usage)
        exit 4
    fi
done


columns="$@"

awk -F " |\t" -v a="$aflag" -v col="$columns" \
'BEGIN {
    sa = 0;
    split(col, colarr, " ");
}
{ 
    s = 0;
    if (length(colarr) == 0)
    {
        for(i = 1; i <= NF; ++i) { 
            s += $i
        };
    }
    else {
        for(i = 1; i <= length(colarr); ++i) {
            s += $colarr[i]
        };
    }
    sa += s;
    print s;
} 
END {
    if (a==1)
        print sa;
}' "$plik"

