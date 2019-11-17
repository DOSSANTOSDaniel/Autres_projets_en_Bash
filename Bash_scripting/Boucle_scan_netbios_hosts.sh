#!/bin/bash

netw="192.168.0"
echo -e "\n ### Scan NetBios ### \n<------------------------------------>\n" > rapport.txt
for (( i=1; i <= 20; i++ ))
do
        testr=$(nbtscan -v $netw.$i | wc -l)

        if [ $testr -ne 2 ]
        then
                nbtscan -v $netw.$i >> rapport.txt
                echo -e "\n" >> rapport.txt
        fi
done

sed -i '/^Doing/d' rapport.txt
sleep 1
cat rapport.txt
