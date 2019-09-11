#!/bin/bash

usage="Usage: $0 plik tekst1 tekst2"

if [[ $# -ne 3 ]] ;
then
    (>&2 echo "Wrong argument count!")
    (>&2 echo $usage)
    exit 1
fi

if [[ ! -f "$1" ]] ;
then 
    (>&2 echo "Input file does not exist!")
    (>&2 echo $usage)
    exit 2
fi

if [[ ! -r "$1" ]] ;
then 
    (>&2 echo "Input file cannot be read!")
    (>&2 echo $usage)
    exit 3
fi

abspath=$(readlink -f $1)
dir=${abspath%/*}


if [[ ! -w "$dir" || ! -x "$dir" ]] ;
then 
    (>&2 echo "Permissions error: no write/execute access to $dir")
    (>&2 echo $usage)
    exit 4
fi

i=1
while [ -f "$1.$i" ];
do
    i=$((i+1))
done

newfile="$1.$i"
com="s/$2/$3/g"

sed -e "$com" $1 > "$newfile"

