#!/bin/bash

rm *.out

filename=$1
declare -a arr
i=0
while IFS=" " read -r -a line; do
    arr[$i]=${line[3]}
    #echo "${arr[$i]}"
    let "i+=1"
done < "$filename"

# echo "$arr"

filename2=$2
declare -a params
i=0
while IFS=" " read -r -a line; do
    for word in "${line[@]}"
    do
        params[$i]=$word
        # echo "${params[$i]}"
        let "i+=1"
    done
done < "$filename2"

filename3=$3
declare -a threads
i=0
while IFS=" " read -r -a line; do
    for word in "${line[@]}"
    do
        threads[$i]=$word
        # echo "${threads[$i]}"
        let "i+=1"
    done
done < "$filename3"

####For Scatter###################
temp=0
declare -a sum1
declare -a sum2
declare -a sum3
declare -a sum4
declare -a sum5
for ((i=0;i<${#threads[@]};i++))
do
    # echo "$i"
    for ((j=0;j<${#params[@]};j++))
    do
        # echo "$j"
        for ((k=0;k<100;k++))
        do
            if [ "$i" == 0 ]
            then
                sum1[$j]=$((${sum1[$j]}+${arr[$temp]}))
                echo "${params[$j]} ${arr[$temp]}" >> scatter1.out
            fi
            if [ "$i" == 1 ]
            then
                sum2[$j]=$((${sum2[$j]}+${arr[$temp]}))
                echo "${params[$j]} ${arr[$temp]}" >> scatter2.out
            fi
            if [ "$i" == 2 ]
            then
                sum3[$j]=$((${sum3[$j]}+${arr[$temp]}))
                echo "${params[$j]} ${arr[$temp]}" >> scatter3.out
            fi
            if [ "$i" == 3 ]
            then
                sum4[$j]=$((${sum4[$j]}+${arr[$temp]}))
                echo "${params[$j]} ${arr[$temp]}" >> scatter4.out
            fi
            if [ "$i" == 4 ]
            then
                sum5[$j]=$((${sum5[$j]}+${arr[$temp]}))
                echo "${params[$j]} ${arr[$temp]}" >> scatter5.out
            fi
            let "temp+=1"
        done
    done
done
# echo "${sum1[0]}"

######################################
#######lineplot################

for ((j=0;j<${#params[@]};j++))
do
    echo "${params[$j]} ${sum1[$j]} ${sum2[$j]} ${sum3[$j]} ${sum4[$j]} ${sum5[$j]}" >> lineplot.out
done
###################################
################  Error Graph##############

declare -a mu1
declare -a mu2
declare -a mu3
declare -a mu4
declare -a mu5

for ((j=0;j<${#params[@]};j++))
do
    mu1[$j]=$(echo "${sum1[$j]}/100.0" | bc -l)
    mu2[$j]=$(echo "${sum2[$j]}/100.0" | bc -l)
    mu3[$j]=$(echo "${sum3[$j]}/100.0" | bc -l)
    mu4[$j]=$(echo "${sum4[$j]}/100.0" | bc -l)
    mu5[$j]=$(echo "${sum5[$j]}/100.0" | bc -l)
done

temp=0
declare -a ex1
declare -a ex2
declare -a ex3
declare -a ex4
declare -a ex5

declare -a exx1
declare -a exx2
declare -a exx3
declare -a exx4
declare -a exx5


for ((j=0;j<${#params[@]};j++))
do
    ex1[$j]=0.0
    ex2[$j]=0.0
    ex3[$j]=0.0
    ex4[$j]=0.0
    ex5[$j]=0.0
    exx1[$j]=0.0
    exx2[$j]=0.0
    exx3[$j]=0.0
    exx4[$j]=0.0
    exx5[$j]=0.0
done

for ((i=0;i<${#threads[@]};i++))
do
    for ((j=0;j<${#params[@]};j++))
    do
        for ((k=0;k<100;k++))
        do
            if [ "$i" == 0 ]
            then
                # ex1[$j]=$(echo "${ex1[$j]}+(${mu1[$j]}/${arr[$temp]})" | bc -l)
                # exx1[$j]=$(echo "${exx1[$j]}+(${mu1[$j]}/-${arr[$temp]})*(${mu1[$j]}/${arr[$temp]})" | bc -l)
                exx1[$j]=$(echo "${exx1[$j]}+${arr[$temp]}*${arr[$temp]}" | bc -l)
                # echo "${exx1[$j]} ${arr[$temp]}"
            fi
            if [ "$i" == 1 ]
            then
                # ex2[$j]=$(echo "${ex2[$j]}+(${mu1[$j]}/${arr[$temp]})" | bc -l)
                # exx2[$j]=$(echo "${exx2[$j]}+(${mu1[$j]}/${arr[$temp]})*(${mu1[$j]}/${arr[$temp]})" | bc -l)
                exx2[$j]=$(echo "${exx2[$j]}+${arr[$temp]}*${arr[$temp]}" | bc -l)
            fi
            if [ "$i" == 2 ]
            then
                # ex3[$j]=$(echo "${ex3[$j]}+(${mu1[$j]}/${arr[$temp]})" | bc -l)
                # exx3[$j]=$(echo "${exx3[$j]}+(${mu1[$j]}/${arr[$temp]})*(${mu1[$j]}/${arr[$temp]})" | bc -l)
                exx3[$j]=$(echo "${exx3[$j]}+${arr[$temp]}*${arr[$temp]}" | bc -l)
            fi
            if [ "$i" == 3 ]
            then
                # ex4[$j]=$(echo "${ex4[$j]}+(${mu1[$j]}/${arr[$temp]})" | bc -l)
                # exx4[$j]=$(echo "${exx4[$j]}+(${mu1[$j]}/${arr[$temp]})*(${mu1[$j]}/${arr[$temp]})" | bc -l)
                exx4[$j]=$(echo "${exx4[$j]}+${arr[$temp]}*${arr[$temp]}" | bc -l)
            fi
            if [ "$i" == 4 ]
            then
                # ex5[$j]=$(echo "${ex5[$j]}+(${mu1[$j]}/${arr[$temp]})" | bc -l)
                # exx5[$j]=$(echo "${exx5[$j]}+(${mu1[$j]}/${arr[$temp]})*(${mu1[$j]}/${arr[$temp]})" | bc -l)
                exx5[$j]=$(echo "${exx5[$j]}+${arr[$temp]}*${arr[$temp]}" | bc -l)
            fi
            let "temp=temp+1"
        done
        if [ "$i" == 0 ]
        then
            ex1[$j]=$(echo "(${exx1[$j]}/100)" | bc -l)
            ex1[$j]=$(echo "${ex1[$j]}-(${mu1[$j]}*${mu1[$j]})" | bc -l)
            ex1[$j]=$(echo "sqrt(${ex1[$j]})" | bc -l)
        fi
        if [ "$i" == 1 ]
        then
            ex2[$j]=$(echo "(${exx2[$j]}/100)" | bc -l)
            ex2[$j]=$(echo "${ex2[$j]}-(${mu2[$j]}*${mu2[$j]})" | bc -l)
            ex2[$j]=$(echo "sqrt(${ex2[$j]})" | bc -l)
        fi
        if [ "$i" == 2 ]
        then
            ex3[$j]=$(echo "(${exx3[$j]}/100)" | bc -l)
            ex3[$j]=$(echo "${ex3[$j]}-(${mu3[$j]}*${mu3[$j]})" | bc -l)
            ex3[$j]=$(echo "sqrt(${ex3[$j]})" | bc -l)
        fi
        if [ "$i" == 3 ]
        then
            ex4[$j]=$(echo "(${exx4[$j]}/100)" | bc -l)
            ex4[$j]=$(echo "${ex4[$j]}-(${mu4[$j]}*${mu4[$j]})" | bc -l)
            ex4[$j]=$(echo "sqrt(${ex4[$j]})" | bc -l)
        fi
        if [ "$i" == 4 ]
        then
            ex5[$j]=$(echo "(${exx5[$j]}/100)" | bc -l)
            ex5[$j]=$(echo "${ex5[$j]}-(${mu5[$j]}*${mu5[$j]})" | bc -l)
            ex5[$j]=$(echo "sqrt(${ex5[$j]})" | bc -l)
        fi
    done
done

for ((j=0;j<${#params[@]};j++))
do
    echo "${params[$j]} ${mu1[$j]} ${mu2[$j]} ${mu3[$j]} ${mu4[$j]} ${mu5[$j]} ${ex1[$j]} ${ex2[$j]} ${ex3[$j]} ${ex4[$j]} ${ex5[$j]}" >> err.out
done
