#!/bin/bash

num=1

until [ $num -gt 34 ]
do
(( num++ ))
#echo $num

cd ~/SFS
touch SummerFondueSessions'#'$num.txt

#exec 1>>SFS.txt
#echo $link

done


