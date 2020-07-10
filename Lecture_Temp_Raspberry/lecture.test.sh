#!/bin/bash

rougefonce='\e[0;31m'
vertfonce='\e[0;32m'
jaune='\e[1;33m'
bleufonce='\e[0;34m'
cyanfonce='\e[0;36m'
neutre='\e[0;m'

dir=/sys/bus/w1/devices/28-*/w1_slave

temp=$(cat $dir | grep "t=" | awk -F "t=" '{print $2/1000}')

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
echo -e ${cyanfonce}"#* "${rougefonce}"Température :"${vertfonce}  ${rougefonce}"°C"${cyanfonce}" *#"
echo -e ${cyanfonce}"#############################"

