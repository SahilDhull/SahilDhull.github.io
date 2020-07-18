#!/bin/bash
let indent=-1
pindent(){
    i=0
    while [ $i -le $indent ]
    do
        echo -n "   "
        ((i++))
    done
}
sent(){
   cnt=$( cat $1 | sed -E 's/([0-9]+\.[0-9]+\.?)+//g' | grep -o -E '[\.\?\!]?*[\.\?\!]' | wc -l )
   scnt=$(( $scnt + $cnt))
}
int(){
    cnt=$( cat $1 | sed -E 's/([0-9]+\.[0-9]+)+//g' | grep -o -E '\-?[0-9]+' | wc -l )
    ncnt=$(( $ncnt + $cnt ))
}
recurse(){
    for files in $( ls "$1")
    do
        if [ -f "$1/$files" ]
        then
            sent "$1/$files"
            int "$1/$files"
        else
            recurse "$1/$files"
        fi
    done
}
out(){
    for file in $( ls "$1" )
    do
        if [ -d "$1/$file" ]
        then
            let scnt=0
            let ncnt=0
            recurse "$1/$file"
            ((indent++))
            pindent
            echo  "(D) $file-$scnt-$ncnt"
            out "$1/$file"
            ((indent--))
        else
            let scnt=0
            let ncnt=0
            if [ -f "$1" ]
            then
                recurse "$1"
            elif [ -f "$1/$file" ]
            then
                sent "$1/$file"
                int "$1/$file"
            fi
            ((indent++))
            pindent
            echo  "(F) $file-$scnt-$ncnt"
            ((indent--))
        fi
    done
}
out $1
let scnt=0
let ncnt=0
recurse "$1"
new=$( echo $1 | grep -o '[^/]*$' )
echo "(D) $new-$scnt-$ncnt"
