if [ $1 -ne 0 ]
then
	num=$(echo $1 | sed 's/^0*//')
fi
len="${#num}"

print_num(){
if [ $flag -eq 1 ]
then
case $1 in
	0) let x=1  ;;
	1) echo -n " one" ;;
	2) echo -n " two" ;;
	3) echo -n " three" ;;
	4) echo -n " four" ;;
	5) echo -n " five" ;;
	6) echo -n " six" ;;
	7) echo -n " seven" ;;
	8) echo -n " eight" ;;
	9) echo -n " nine" ;;
esac
else
case $1 in
        0) let x=1  ;;
        1) echo -n "one" ;;
        2) echo -n "two" ;;
        3) echo -n "three" ;;
        4) echo -n "four" ;;
        5) echo -n "five" ;;
        6) echo -n "six" ;;
        7) echo -n "seven" ;;
        8) echo -n "eight" ;;
        9) echo -n "nine" ;;
esac
fi
}

print_ten(){
if [ $flag -eq 1 ]
then
case $1 in
	0) let x=1  ;;
        1) echo -n " ten" ;;
        2) echo -n " twenty" ;;
        3) echo -n " thirty" ;;
        4) echo -n " fourty" ;;
        5) echo -n " fifty" ;;
        6) echo -n " sixty" ;;
        7) echo -n " seventy" ;;
        8) echo -n " eighty" ;;
        9) echo -n " ninety" ;;
esac
else
case $1 in
	0) let x=1  ;;
        1) echo -n "ten" ;;
        2) echo -n "twenty" ;;
        3) echo -n "thirty" ;;
        4) echo -n "fourty" ;;
        5) echo -n "fifty" ;;
        6) echo -n "sixty" ;;
        7) echo -n "seventy" ;;
        8) echo -n "eighty" ;;
        9) echo -n "ninety" ;;
esac
fi
}

print_teen(){
if [ $flag -eq 1 ]  
then
case $1 in 
	10) echo -n " ten" ;;
        11) echo -n " eleven" ;;
        12) echo -n " twelve" ;;
        13) echo -n " thirteen" ;;
        14) echo -n " fourteen" ;;
        15) echo -n " fifteen" ;;
        16) echo -n " sixteen" ;;
        17) echo -n " seventeen" ;;
        18) echo -n " eighteen" ;;
        19) echo -n " nineteen" ;;
esac
else
case $1 in
	10) echo -n "ten" ;;
	11) echo -n "eleven" ;;
        12) echo -n "twelve" ;;
        13) echo -n "thirteen" ;;
        14) echo -n "fourteen" ;;
        15) echo -n "fifteen" ;;
        16) echo -n "sixteen" ;;
        17) echo -n "seventeen" ;;
        18) echo -n "eighteen" ;;
        19) echo -n "nineteen" ;;
esac
fi
}


n=$(( $len-1 ))
let flag=0
let ind_a=0
let ind_b=0
let ind_c=0
if [ $1 -eq 0 ]
then
echo "zero"
elif [ $num -le 99999999999 ] && [ $num -ge 0 ]
then
if [ $n -eq 10 ]
then
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	echo -n " thousand"
	((ind_a++))
	let flag=1
	((n--))
fi
if [ $n -eq 9 ]
then
	let x=0
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	if [ $x -eq 0 ]
	then
	echo -n " hundred"
	((ind_a++))
	fi
	let flag=1
	((n--))
fi
if [ $n -eq 8 ]
then
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	if [ $digit -eq 1 ]
	then
	((i++))
	digit1=$(( $(echo $num | cut -c $i) + 10 ))
	print_teen $digit1
	echo -n " crore"
	((n-=2))
	else
	print_ten $digit
	((n--))
	fi
	if [ $digit -ne 0 ] 
	then
	((ind_a++))
	fi
	let flag=1
fi
if [ $n -eq 7 ]
then
	let x=0
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	if [ $x -eq 0 ] || [ $ind_a -ne 0 ]
	then
	echo -n " crore"
	fi
	let flag=1
	((n--))	
fi
if [ $n -eq 6 ]
then
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	if [ $digit -eq 1 ]
        then
        ((i++))
        digit1=$(( $(echo $num | cut -c $i) + 10 ))
        print_teen $digit1
        echo -n " lakh"
        ((n-=2))
        else
        print_ten $digit
        ((n--))
        fi
	if [ $digit -ne 0 ]
        then
        ((ind_b++))
        fi
	let flag=1
fi
if [ $n -eq 5 ]
then
	let x=0
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	if [ $x -eq 0 ] || [ $ind_b -ne 0 ]
	then
	echo -n " lakh"
	fi
	let flag=1
	((n--))
fi
if [ $n -eq 4 ]
then
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	if [ $digit -eq 1 ]
        then
        ((i++))
        digit1=$(( $(echo $num | cut -c $i) + 10 ))
        print_teen $digit1
        echo -n " thousand"
        ((n-=2))
        else
        print_ten $digit
        ((n--))
        fi
	if [ $digit -ne 0 ]
        then
        ((ind_c++))
        fi
	let flag=1
fi
if [ $n -eq 3 ]
then
	let x=0
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	if [ $x -eq 0 ] || [ $ind_c -ne 0 ]
	then
	echo -n " thousand"
	fi
	let flag=1
	((n--))
fi
if [ $n -eq 2 ]
then
	let x=0
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	if [ $x -eq 0 ]
	then
	echo -n " hundred"
	fi
	let flag=1
	((n--))
fi
if [ $n -eq 1 ]
then
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	if [ $digit -eq 1 ]
        then
        ((i++))
        digit1=$(( $(echo $num | cut -c $i) + 10 ))
        print_teen $digit1
        ((n-=2))
        else
        print_ten $digit
        ((n--))
        fi
	let flag=1
fi
if [ $n -eq 0 ]
then
	i=$(( $len - $n ))
	digit=$(echo $num | cut -c $i)
	print_num $digit
	let flag=1
	((n--))
fi
echo
else
	echo "invalid input"
fi
