#!/bin/bash

#************************************************#
# Nom:     connport.sh                           #
# Auteur:  toto <dossantosjdf@gmail.com>         #
# Date:    11/03/2021                            #
# Version: 1.0                                   #
#                                                #
# Rôle:    Ce script permet de detecter quand    #
#          un certain port est en fonctionnement #
#          sur une machine.                      #
#                                                #
# Usage:   ./connport.sh                         #
#************************************************#

trap 'echo -e "\n Fin du script !" && exit' INT

### Fonctions
bann_spt() {
  echo "   ____                            _                ___  _  __  _ ";
  echo "  / ___|___  _ __  _ __   _____  _(_) ___  _ __    / _ \| |/ / | |";
  echo " | |   / _ \| '_ \| '_ \ / _ \ \/ / |/ _ \| '_ \  | | | | ' /  | |";
  echo " | |__| (_) | | | | | | |  __/>  <| | (_) | | | | | |_| | . \  |_|";
  echo "  \____\___/|_| |_|_| |_|\___/_/\_\_|\___/|_| |_|  \___/|_|\_\ (_)";
  echo "                                                                  ";
  echo -e "$(date '+%x %X') >>  Port : ${port_srv} \n"
  echo "Pour quitter le script : Control+c"
}

i_need() {
  app_deb="${1}"
  app_rpm="${2}"

  if (command -v apt-get 2> /dev/null)
  then
    apt-get update -q
    if ! (apt-get install -qy "${app_deb}")
    then
      echo "'ERREUR' Installation de ${app_deb} Impossible!"
      exit 1
    fi
  elif (command -v dnf 2> /dev/null)
  then
    dnf check-update
    if ! (dnf install -qy "${app_rpm}")
    then
      echo "'ERREUR' Installation de ${app_rpm} Impossible!"
      exit 1
    fi
  elif (command -v yum 2> /dev/null)
  then
    yum check-update
    if ! (yum install -qy "${app_rpm}")
    then
      echo " 'ERREUR' Installation de ${app_rpm} Impossible!"
      exit 1
    fi
  else
    echo -e "\n Gestionnaire de paquets non prit en charge !"
    exit 1
  fi
}

### Variables
ip_srv='87.88.200.33'
port_srv='2244'
loop_noise='2'
timeout_min='15' #En minutes

app_deb='netcat'
app_rpm='nc'

### Main
clear
echo
echo "    Début script connport.sh"
echo "----------------------------"
echo

if [[ "$OSTYPE" == 'linux-gnu' ]]
then
  ! command -v netcat 2> /dev/null && ! command -v nc 2> /dev/null && i_need ${app_deb} ${app_rpm}
else
  echo -e "\n Système non prit en charge : ${OSTYPE} \n"
  exit 1
fi

timeout_detect="$((timeout_min*60))"

clear
echo
echo "     Configurations"
echo "----------------------------"
echo "IP serveur : ${ip_srv}"
echo "Port serveur : ${port_srv}"
echo "Boucle son : Rejoue ${loop_noise} fois le son par boucle."
echo "Timeout : ${timeout_min} minutes."
echo

while :
do
  if (nc -vz "${ip_srv}" "${port_srv}" > /dev/null 2>&1)
  then
    if [[ "${LOGNAME}" == 'root' ]]
    then
      bann_spt
      modprobe pcspkr
      for ((i=1;i<=loop_noise;i++))
      do
        echo -e '\a' > /dev/console && sleep 1
      done
    else
      bann_spt
      for ((i=1;i<=loop_noise;i++))
      do
        timeout 1 speaker-test -l 1 -P 2 -p 1 -t sine > /dev/null 2>&1
	aplay -d 1 -q -t wav -f cd /usr/share/sounds/alsa/Noise.wav > /dev/null 2>&1
        paplay /usr/share/sounds/freedesktop/stereo/phone-incoming-call.oga > /dev/null 2>&1
      done
    fi
  else
    echo -e "\n$(date '+%x %X') :\tPas de connexion sur le port ${port_srv} pour l'instant !"
    echo -e "\t\t\tPour quitter le script : Control+c"
  fi
  sleep "${timeout_detect}"
done
