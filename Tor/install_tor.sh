#!/bin/bash

# Variables
utilisateur=$(who | awk '{print $1}')

# dépendances
apt update
apt install figlet -y
apt install lynx -y

clear

figlet -c Darknet

mkdir /home/"$utilisateur"/Documents/TOR/ > /dev/null 2>&1

cd /home/"$utilisateur"/Documents/TOR/ > /dev/null 2>&1

lynx -dump https://dist.torproject.org/torbrowser | sed "13 q"
echo ""
read -p "Quelle version de tor voulez-vous ? (exemple 9.0.1) : " versiontor

# Téléchargement de tor
wget https://dist.torproject.org/torbrowser/"$versiontor"/tor-browser-linux64-"$versiontor"_fr.tar.xz
    
# Extraction
tar xvf tor-browser-linux64*
    
cd tor-browser_fr/ > /dev/null 2>&1
    
# Création du raccourci
./start-tor-browser.desktop --register-app
    
# Bug root
if [ "$(id -u)" -eq 0 ]; then
           sed -i -e 's/-eq 0/-eq 1000/' /root/Downloads/tor-browser_fr/Browser/start-tor-browser 
fi

clear
echo ""
figlet -c "Bienvenu dans le Darknet!"

# Supprimer dépendances
apt remove figlet -y > /dev/null 2>&1
apt remove lynx -y > /dev/null 2>&1
sudo rm -rf /home/"$utilisateur"/Documents/TOR/*_fr.tar.xz > /dev/null 2>&1
/home/"$utilisateur"/Documents/TOR/tor-browser_fr/Browser/start-tor-browser --detach
