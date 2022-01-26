#!/bin/bash
re='^[0-9]+$'
while ! [[ $number =~ $re ]] || [ $number -eq 0 ]
do 
	echo Please input integer number 
	read number 
done
let "factorial = 1"
for i in $(eval echo "{1..$number}")
do
	let "factorial = factorial * $i"
done

echo The factirial of $number is $factorial
