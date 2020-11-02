#!/bin/bash

apt update
apt full-update -y

useradd -m -g mangkone -s /bin/bash mangkone
sleep 2
passwd mangkone

apt install sudo -y
usertos=$(w | awk '{print $1}' | awk 'NR==3')
usermod -aG sudo "$usertos"

apt install vim -qqy
apt install htop ncdu screen nmap -qqy
apt install software-properties-common -qqy
apt install git -y
apt install tree -y
