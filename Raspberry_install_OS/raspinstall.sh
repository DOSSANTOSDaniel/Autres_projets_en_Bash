#!/bin/bash
clear
echo -e "\n *** Téléchargement de l'image *** \n"
read -p "URL de l'image ? [ http://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz ] : " URL
URL=${URL:-http://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz}
wget $URL
echo -e "\n *** Décompresser l'image *** \n"
read -p "Image img ? [ ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz ] : " IMAGE
IMAGE=${IMAGE:-ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz}
xz -d $IMAGE
echo -e "\n *** Création de la clé sd *** \n"
echo -e "\n Les cartes SD montées"
echo -e "-------------------------"
lsblk
echo ""
IMAGEXZ='ubuntu-20.04-preinstalled-server-arm64+raspi.img'
read -p "Choisir la carte SD : " CHOIX
dd bs=1M if=$IMAGEXZ of=/dev/$CHOIX status=progress conv=fsync
echo -e "\n *** L'installation est terminée *** \n"
echo 'Il vous suffit de créer un fichier nommé ssh dans la partition boot de la SD puis connecter votre carte sur le Raspberry PI'

