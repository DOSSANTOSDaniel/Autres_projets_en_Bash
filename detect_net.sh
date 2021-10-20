#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name: detect_net.sh	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date: dim. 19 sept. 2021 17:55:41                                             
# Version: 1.0                                      
# Bash_Version: 5.0.17(1)-release                                     
#--------------------------------------------------#
# Description:                                      
#                                                   
#                                                   
# Options:                                          
#                                                   
# Usage: ./detect_net.sh                                            
#                                                   
# Limits:                                           
#                                                   
# Licence:                                          
#--------------------------------------------------#

set -eu

### Includes ###

### Constants ###

### Fonctions ###

### Global variables ###

### Main ###

echo -e "\n============== Connection interface internet =============="

for int_net in /sys/class/net/*
do
  if [[ $int_net != "/sys/class/net/lo" ]]
  then
    i_net="$(basename $int_net)"
    sudo ip link set dev "$i_net" up
    if [ $(cat "$int_net"/operstate) == "up" ]
    then
      echo "$i_net : Connecté"
    elif [ $(cat "$int_net"/operstate) == "down" ]
    then
      echo "$i_net : Non connecté"
    else
      echo "$i_net : Valeur inconnue !"
    fi
  fi
done

echo -e "===========================================================\n"
