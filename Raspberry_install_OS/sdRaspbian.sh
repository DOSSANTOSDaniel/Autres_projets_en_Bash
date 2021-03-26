#!/bin/bash

# téléchargement de l'image
wget https://downloads.raspberrypi.org/raspbian_full_latest

# dézipper img
unzip raspbian_*
imgg="2019-04-08-raspbian-stretch-full.img"

# création de la clé sd
echo -e "\n voila les sd \n"
lsblk
read -p "choisir la sd" choix
dd bs=1M if=$imgg of=/dev/$choix status=progress conv=fsync
echo -e "\n la carte sd est terminée \n"
echo 'Il vous suffit de créer un fichier
nomé ssh dans la partition boot de la sd'

