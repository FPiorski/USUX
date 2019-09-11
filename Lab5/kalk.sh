#!/bin/bash

usage="Usage: $0 arg op (arg op arg) ..."

if [ $# -lt 3 ]
then
    echo $usage
    exit 1
fi

str=" $* "

tmp=$str
bra=0;
for (( i=0; i<${#tmp}; i++ )); do
    char="${tmp:$i:3}"
    if [ "$char" = " ( " ]
    then
        bra=$((bra+1))
    fi
    if [ "$char" = " ) " ]
    then
        bra=$((bra-1))
    fi
    if [ "$bra" -gt 1 ]
    then
        echo "Nested brackets are not supported"
        exit 1
    fi
    if [ "$bra" -lt 0 ]
    then
        echo "Brackets error"
        exit 1
    fi
done

if [ "$bra" -ne 0 ]
then
    echo "Brackets error"
    exit 1
fi

#states: 0 - start
#1 - operand outside of bracket
#2 - operator outside of bracket
#3 - operand inside of bracket
#4 - operator inside of bracket

state=0
valnb=0
opnb="+"
valb=0
opb="+"
if [ "$1" = "(" ]
then
    state=3
fi
if [ "$1" -eq "$1" 2>/dev/null ]
then
    valnb="$1"
    state=2
fi
if [ "$state" -eq  0 ]
then
    echo "Syntax error"
    exit 1
fi

shift

while [[ $1 ]] ;
do
    #echo "$state"
    if [ "$1" = ")" ]
    then
        if [ "$state" -eq 4 ]
        then
            #echo " $opnb $valb"
            if [[ "$opnb" = "/" && "$valb" -eq 0 ]] ;
            then
                echo "Division by 0!"
                exit 3
            fi
            state=2
            valnb=`expr $valnb $opnb $valb 2>/dev/null`
            shift
            continue
        else
            echo "Syntax error"
            exit 2
        fi
    fi

    if [ "$1" = "(" ]
    then
        valb=0
        opb="+"
        if [ "$state" -eq 1 ]
        then
            state=3
            shift
            continue
        else
            echo "Syntax error"
            exit 4
        fi
    fi

    if [ "$state" -eq  1 ]
    then
        if [ "$1" -eq "$1" 2>/dev/null ]
        then
            if [[ "$opnb" = "/" && "$1" -eq 0 ]] ;
            then
                echo "Division by 0!"
                exit 3
            fi
            state=2
            if [[ $opnb = "+" ]] ;
            then
                valnb=`expr $valnb + $1 2>/dev/null`
            fi
            if [[ $opnb = "-" ]] ;
            then
                valnb=`expr $valnb - $1 2>/dev/null`
            fi
            if [[ $opnb = "*" ]] ;
            then
                valnb=`expr $valnb \* $1 2>/dev/null`
            fi
            if [[ $opnb = "/" ]] ;
            then
                valnb=`expr $valnb / $1 2>/dev/null`
            fi
            shift
            continue
        else
            echo "Only integer operands are allowed"
            exit 5
        fi
    fi
    
    if [ "$state" -eq  2 ]
    then
        if [[ "$1" = "+" || "$1" = "-" || "$1" = "/" || "$1" = "*" ]];
        then
            opnb="$1"
            state=1
            shift
            continue
        else
            echo "The only allowed operators are + - * /"
            exit 6
        fi
    fi
    
    if [ "$state" -eq  3 ]
    then
        if [ "$1" -eq "$1" 2>/dev/null ]
        then
            if [[ "$opb" = "/" && "$1" -eq 0 ]] ;
            then
                echo "Division by 0!"
                exit 3
            fi
            state=4
            if [[ $opb = "+" ]] ;
            then
                valb=`expr $valb + $1 2>/dev/null`
            fi
            if [[ $opb = "-" ]] ;
            then
                valb=`expr $valb - $1 2>/dev/null`
            fi
            if [[ $opb = "*" ]] ;
            then
                valb=`expr $valb \* $1 2>/dev/null`
            fi
            if [[ $opb = "/" ]] ;
            then
                valb=`expr $valb / $1 2>/dev/null`
            fi
            shift
            continue
        else
            echo "Only integer operands are allowed"
            exit 8
        fi
    fi

    if [ "$state" -eq  4 ]
    then
        if [[ "$1" = "+" || "$1" = "-" || "$1" = "/" || "$1" = "*" ]];
        then
            opb="$1"
            state=3
            shift
            continue
        else
            echo "Only + - * / are allowed as operators"
            exit 7
        fi
    fi
done

if [ "$state" -eq  1 ]
then
    echo "Syntax error (trailing operator)"
    exit 8
else
    echo "$valnb"
    exit 0
fi
