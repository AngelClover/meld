#!/bin/sh


if [ $# -ne 2 ]

then
    echo Usage: compare.sh fold_name_1 fold_name_2
    exit
fi

if [ ! -d $1 ]
then
    echo $1 is not a 
    exit
fi

if [ ! -d $2 ]
then
    echo $2 is not a 
    exit
fi

fold1=$(echo $1 | sed 's|\(^[^/]*\).*|\1|')
fold2=$(echo $2 | sed 's|\(^[^/]*\).*|\1|')

compareFOLD()
{
    for file in $1/*
    do
        if [ -d $file ] then
            compareFOLD $file
        elif [ -f $file ]
        then
            if [ ! -L $file ]
            then
                file2=$(echo $file | sed "s|^.[^/]*\(.*\)|$fold2\1|")
                diff $file $file2
                if [ $? -ne 0 ]
                then
                    echo -e "\033[32m"$file
                    echo $file2
                    echo -e "\033[0m"---------------------------------------------------------------------
                fi
            fi
        fi
    done
}

compareFOLD $fold1