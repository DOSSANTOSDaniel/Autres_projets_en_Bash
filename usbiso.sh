#!/bin/bash

#************************************************#
# Nom:     usbiso.sh                             #
# Auteur:  daniel <daniel.massy91@gmail.com>     #
# Date:    07/03/2021                            #
# Version: 1.0                                   #
#                                                #
# Rôle:    Permet de créer des clé usb bootables.#
#                                                #
# Usage:   ./usbiso.sh                           #
#                                                #
#************************************************#

if [ "${LOGNAME}" != "root" ]
then
  echo -e "\n Le script doit être exécuté en tant que root ! \n"
  exit 3
fi

### Fonctions ###
menu() {
echo -e "\n -- Menu fichiers -- "
select ITEM in "${files[@]}" 'Retour' 'Quitter'
do
  if [[ "${ITEM}" == "Quitter" ]]
  then
    echo "Fin du script !"
    exit 1
  elif [[ "${ITEM}" == "Retour" ]]
  then
    retour
    break
  else
    total="${total}/${ITEM}"
    ((count++))
    break
  fi
done
}

retour() {
if [[ ${count} -gt 0 ]]
then
  total=$(dirname "${total}")
  ((count--))
fi
}

### Variables ###
PS3="Votre choix : "
total="$(pwd)"
mapfile -t files < <(ls "${total}")
#files=($(ls "${total}"))
count=0
iso=''


while :
do
  #files=($(ls "${total}"))
  mapfile -t files < <(ls "${total}")  
  menu
  if [[ -f "${total}" ]]
  then
    echo "Choix ISO : ${ITEM}"
    iso=$(mimetype -b "${total}")
    break
  fi
done

clear
lsblk -ld -I 8 -o NAME,TYPE,SIZE,MODEL
echo
echo "Menu disque"
echo "--------------"
#options=($(lsblk -ldn -I 8 -o NAME))
mapfile -t options < <(lsblk -ldn -I 8 -o NAME)
select opt in "${options[@]}"
do
  nbopt="${#options[@]}"

  if [[ "${REPLY}" -le "${nbopt}" ]]
  then
    usbdev="${opt}"
    break
  else
    echo -e "\n Erreur de saisie ! \n"
    exit 1
  fi  
done

if [[ "${iso}" == 'application/x-cd-image' ]]
then
  size=$(du -s "${total}" | cut -f1)
  echo
  #BS= 512 (default), 4096 (4K), 65536 (64K), 1048576 (1M), 4194304 (4M)
  dd if="${total}" | pv -s "${size}"k | dd of=/dev/"${usbdev}" bs=1M oflag=sync
else
  echo -e "\n Le fichier ${total} n'est pas de type ISO \n"
fi

echo -e "\n Fin du script"
