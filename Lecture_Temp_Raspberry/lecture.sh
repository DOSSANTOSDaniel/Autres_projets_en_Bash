#!/bin/bash


rougefonce='\e[0;31m'
vertfonce='\e[0;32m'
jaune='\e[1;33m'
bleufonce='\e[0;34m'
cyanfonce='\e[0;36m'
neutre='\e[0;m'

dir=/sys/bus/w1/devices/28-*/w1_slave
temp_a=$(cat $dir | grep 't=' | cutt="cut -d'=' -f2")

echo "$(tput setaf 2)
   .~~.   .~~.
  '. \ ' ' / .'$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :
 ~ (   ) (   ) ~
( : '~'.~.'~' : )
 ~ .~ (   ) ~. ~
  (  : '~' :  )
   '~ .~~~. ~'
       '~'
$(tput sgr0)"


echo -e ${rougefonce}"Raspberry Pi"
echo -e ${rougefonce}"------------"
echo ""

echo -e ${cyanfonce}"#############################"
echo -e ${cyanfonce}"#*${vertfonce}[0] Valeur fixe      ${cyanfonce}*#"
echo -e ${cyanfonce}"#*${vertfonce}[1] Valeur temps réel${cyanfonce}*#"
echo -e ${cyanfonce}"#*${vertfonce}[2] Valeur défilement${cyanfonce}*#"
echo -e ${cyanfonce}"#############################"

read -p "Choisisez une des trois fonctions : " choix

case $choix in
  0) 
echo -e ${cyanfonce}"#############################"
echo -e ${cyanfonce}"#* "${rougefonce}"Température :"${vertfonce} $temp ${rougefonce}"°C"${cyanfonce}" *#"
echo -e ${cyanfonce}"#############################";;
  2) 
while [ : ]
do
$temp
done
;;
  1)
dir=/sys/bus/w1/devices/28-*/w1_slave
a="cat $dir | grep 't=' | cut -d'=' -f2"

#watch -d -t -n 1 --exec bash -c 
b="find /sys/bus/w1/devices/ -name '28-*' -exec cat {}/w1_slave \; | grep 't=' | awk -F 't=' '{print $2/1000}'"
watch -d -t -n 1 --exec bash -c "echo $b"

#watch -d -t -n 1 --exec bash -c "cat $dir | grep 't=' | awk -F "t=" '{print $2/1000}'" #cut -d'=' -f2 | awk '{print (($1)/1000)}'
#watch -d -t -n 1 --exec bash -c "expr $a/1000"
;;
  *) echo "ERREUR SYNTAXE"
esac

