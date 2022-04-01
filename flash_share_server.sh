#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name: flash_share.sh	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date: mar. 22 juin 2021 18:48:32                                             
# Version: 1.0                                      
# Bash_Version: 5.0.17(1)-release                                     
#--------------------------------------------------#
# Description:                                      
#                                                   
#                                                   
# Options:                                          
#                                                   
# Usage: ./flash_share.sh                                            
#                                                   
# Limits:                                           
#                                                   
# Licence:                                          
#--------------------------------------------------#

#set -eu

### Includes ###

### Constants ###

### Fonctions ###

### Global variables ###
ip_host="$(hostname -I | awk '{print $1}')"
ip_pub="$(curl ifconfig.me)"

### Main ###

# Banner
cat << "EOF"
 _____ _           _             _                    
|  ___| | __ _ ___| |__      ___| |__   __ _ _ __ ___ 
| |_  | |/ _` / __| '_ \    / __| '_ \ / _` | '__/ _ \
|  _| | | (_| \__ \ | | |   \__ \ | | | (_| | | |  __/
|_|   |_|\__,_|___/_| |_|___|___/_| |_|\__,_|_|  \___|
                       |_____|                        
EOF

python_installed='false'
default_port='8000'

# Check python3
if ! (python3 --version)
then
  Sudo apt update && (sudo apt install python3 || exit 1)
fi

# Vérifier que le port 8000 n'est pas déjà utilisé
# IPv4 Ports
mapfile -t tab_ipv4 < <(sudo ss -tulpn | grep LISTEN | awk -F ':' '{print $2}' | cut -d' ' -f1 | tr ' ' '\n')

# IPv6 Ports
mapfile -t tab_ipv6 < <(sudo ss -tulpn | grep LISTEN | awk -F ']:' '{print $2}' | cut -d' ' -f1 | tr ' ' '\n')

# All ports
listen_ports=( $(echo "${tab_ipv4[@]} ${tab_ipv6[@]}" | tr ' ' '\n' | sort -u) )

# Check
for i in $listen_ports[@]
do
  if [[ $i == $default_port ]]
  then
    ((default_port++))
  fi
done

# Select directory
IFS=$'\n'
PS3='Votre choix: '

full_path='/home'
count=0

sleep 3

until [ ${ITEM} == "Ici" ]
do
  clear
  echo -e "\n[-- Menu fichiers --->\n"

  mapfile -t files < <(ls ${full_path})

  select ITEM in "${files[@]}" 'Quitter' 'Ici' 'Retour' 
  do
    if [[ "${ITEM}" == "Quitter" ]]
    then
      exit 1
    elif [[ "${ITEM}" == "Ici" ]] 
    then
      full_path="$full_path"
      break
    elif [[ "${ITEM}" == "Retour" ]]
    then
      if [[ ${count} -gt 0 ]]
      then
        full_path=$(dirname "$full_path")
        set +e
        ((count--))
        set -e
        break
      elif [[ ${count} -eq "0" ]]
      then
        full_path="$full_path"
        break
      fi
    else
      full_path="${full_path}/${ITEM}"
      ((count++))
      break
    fi
  done
done

# Start http server
echo
echo "En LAN:"
echo -e "\n Pour vous connecter tapez [ http://${ip_host}:${default_port} ] sur un navigateur Web. \n"
echo "En WAN:"
echo -e "\n Pour se connecter au travers internet tapez [ http://${ip_pub}:${default_port} ] sur un navigateur Web. \n"
echo ">>> Il faut ouvrir le port ${default_port} sur votre box internet (FAI)"
echo
echo -e "\n Pour arreter le partage tapez [ Ctrl+c ] sur le terminal. \n"
python3 -m http.server $default_port --directory $full_path
