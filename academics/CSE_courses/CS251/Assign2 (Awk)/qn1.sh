#!/bin/bash

count(){
    let cmnt=0
    let str=0
    rename 's/ /_/g' $1/*
    for file in $1/*
    do
        if [ -d $file ]
        then
            count $file
        elif [[ "${file: -2}"==".c" ]]
        then
            out=$(awk -f q1.awk $file)
            icmnt=$(cut -d' ' -f1 <<< $out)
            istr=$(cut -d' ' -f2 <<< $out)
            let cmnt+=icmnt
            let str+=istr
            
        fi
    done
}
count $1
echo "$str strings and $cmnt lines of comments."

