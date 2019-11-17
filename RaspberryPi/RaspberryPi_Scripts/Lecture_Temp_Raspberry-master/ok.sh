#!/bin/bash

#function abc
#{
dir=/sys/bus/w1/devices/28-*/w1_slave

temp=$(cat $dir | grep "t=" | awk -F "t=" '{print $2/1000}')

#echo "Température : $temp°C"
#}

#while [ : ]
#do
#clear
#abc
#sleep 1
#done

#bash -c `while [ : ]; do $temp; sleep 1; done`
#while :; do clear; $temp; echo; sleep 2; done

clearline="\b\033[2K\r"
while true 
do
    eval "$temp"
    sleep 2
    echo -n -e "$clearline"
done
