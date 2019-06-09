#!/bin/bash

num=53

until [ $num -gt 216 ]
do
(( num++ ))

#echo $num

link=http://www.summerfondue.ru/archive/SummerFondueSessions0$num.mp3

exec 1>>SFS.txt
echo $link

done
