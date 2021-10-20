#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name: todolist.sh	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date: sam. 16 oct. 2021 19:45:51                                             
# Version: 1.0                                      
# Bash_Version: 5.0.17(1)-release                                     
#--------------------------------------------------#
# Description:                                      
#                                                   
#                                                   
# Options:                                          
#                                                   
# Usage: ./todolist.sh                                            
#                                                   
# Limits:                                           
#                                                   
# Licence:                                          
#--------------------------------------------------#

set -e

### Includes ###

### Constants ###

### Fonctions ###
usage() {
  cat << EOF
  
  ___ Script : $(basename ${0}) ___
  
  ./$(basename ${0}) -[h|v|a|r|c]
  ./$(basename ${0}) --[help|version|add|remove|critical]
  
  Rôle:                                          
  Ce script permet de créer une todo liste.

  Usage:
  -h | --help : Aide.
  -v | --version : Affiche la version.
  -a | --add : Ajoute une ligne.
  -r | --remove : Suprime une ligne.
  -c | --critical : Détermine les tâches urgentes.
  
  Exemples :
  
  Affiche la version du script : ./$(basename ${0}) -v
  Ajoute une ligne : ./$(basename ${0}) -a 'Mon texte'
  Supprime une ligne, chaque ligne est numéroté : ./$(basename ${0}) -r '15488'
  
EOF
}

version() {
  local ver='1'
  local dat='16/10/21'
  cat << EOF
  
  ___ Script : $(basename ${0}) ___
  
  Version : ${ver}
  Date : ${dat}
  
EOF
}

# Add line
todo_add() {
  text="$(echo $text | cut -d ' ' -f2-100)"
  echo "$RANDOM : $text" >> $LIST
}

# Remove line
todo_del() {
  text="$(echo $text | cut -d ' ' -f2-100)"
  sed -i "/$text/d" $LIST
}

# Critical line
todo_critical() {
  # Colors
  red="\e[31m"
  neutral="\e[m"
  
  nb_text="$(echo $text | cut -d ' ' -f2)"
  
  line_text="$(grep $nb_text $LIST)"
  
  regex="^[0-9]"
  
  line_0="$(echo $line_text | cut -d ' ' -f1)"
  
  if [[ "$line_0" =~ "$regex" ]]
  then
    echo "numéro"
    sed -i "/^$nb_text/d" $LIST
    echo -e "${red}${line_text}${neutral}" >> $LIST
  else
    echo "couleur"
    grep $line_text $LIST >> $LIST
  fi
}

### Global variables ###

export LIST="${HOME}/todolist.txt"  

option="$1"

text="$*"

nb_lines="$(wc -l $LIST | cut -d ' ' -f1)"

### Main ###
clear

if [ -e $LIST ] && [ -f $LIST ]
then
  echo ""
else
  touch $LIST
fi

if [ $# -eq 0 ]
then
  if [ $nb_lines == 0 ]
  then
    echo 'La liste est vide !'
  fi
  echo -e "\n# ___ TODO list ___ #\n"
  cat $LIST
fi

case "${option}" in
    -a | --add)  todo_add ;;
    --remove | -r) todo_del ;;
    --critical | -c) todo_critical ;;
    --help | -h) usage ;;
    --version | -v) version ;;
    *)exit 1 ;;
esac
