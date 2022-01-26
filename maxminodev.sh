#!/bin/bash
re='^[0-9]+$'
declare -a args
declare -a args_even
declare -a args_odd
for i in $@
do
	if ! [[ $i =~ $re ]] || [ $# -lt 2 ]
	then
		echo "error: you enter not number or less than 2 element, try again"
		exit 1
	else
		args[${#args[@]}]="$i"
	fi
done
echo $@
echo ${args[*]}
let "n=${#args[*]}-2"
echo $n
let "m=${#args[*]}-1"
echo $m
for i in $(eval echo "{0..$m}")
do
	for k in  $(eval echo "{0..$n}")
	do
		if [ ${args[$k]} -gt ${args[$k+1]} ]
		then
			let "unknown = ${args[$k]}"
			let "args[$k] = ${args[$k+1]}"
			let "args[$k+1] = $unknown"			
		fi
	done
done
echo ${args[*]}
let "min=$1"
let "max=$1"
odd_count=0
even_count=0
for i in $@
do
	if [ $i -le $min ]
	then
		let "min=$i"
	else
		let "max=$i"
	fi
	if [ $[$i % 2] -eq 0 ]
	then
		let "odd_count=odd_count+1"
		args_odd[${#args_odd[@]}]="$i"
		
	else
		let "even_count=even_count+1"
		args_even[${#args_even[@]}]="$i"
	fi
done
echo Minimum value is $min
echo maximum value is $max
echo Odd numbers count is $odd_count
echo Odd numbers is  ${args_odd[*]}
echo Even number count is $even_count
echo Even numbers is ${args_even[*]}
