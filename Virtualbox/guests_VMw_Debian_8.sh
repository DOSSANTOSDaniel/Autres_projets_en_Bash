#!/bin/bash

# TITRE: Additions invités VMware Debian 8
#================================================================#
# DESCRIPTION:
#  Installation des additions invité sur une machine virtuelle
#  sous Debian 8. 
#----------------------------------------------------------------#
# AUTEURS:
#  Daniel DOS SANTOS < danielitto91@gmail.com >
#----------------------------------------------------------------#
# DATE DE CRÉATION: 27/05/2018
#----------------------------------------------------------------#
# VERSIONS: 1.0.0
#----------------------------------------------------------------#
# USAGE: ./guests_VMw_Debian_8.sh
#----------------------------------------------------------------#
# NOTES:
#  Outils utilisés VMware 14, Debian 8.10, machine Phisique Debian 9.4
#----------------------------------------------------------------#
# BASH VERSION: GNU bash 4.4.12
#================================================================#

#___Déclaration des variables de couleur
vertclair='\e[1;32m'
orange='\e[0;33m'
jaune='\e[1;33m'
neutre='\e[0;m'
bleuclair='\e[1;34m'
rougefonce='\e[0;31m'

function red_err
        {
        echo -e "$rougefonce
         ______________
        ||             |
        || # $1
        ||°°°°°°°°°°°°°
        || >_ $2
        ||_____________|
        |______________|
         \\== = = = = = =\\
          \\==============\\
           \\======____====\\
            \\_____\\___\\____\\
	$neutre"
	read -p "Valider pour continuer !"
        }

#___Mises à jour et autres paquets globales
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install screenfetch -y
aptitude install bzip2 -y
sleep 3
clear
screenfetch

#Installation de Debian 8 Jessie
echo "
deb http://ftp.fr.debian.org/debian/ jessie main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ jessie main

deb http://security.debian.org/ jessie/updates main
deb-src http://security.debian.org/ jessie/updates main

# jessie-updates, previously known as 'volatile'
deb http://ftp.fr.debian.org/debian/ jessie-updates main
deb-src http://ftp.fr.debian.org/debian/ jessie-updates main
" > /etc/apt/sources.list

echo -e "$vertclair \n Dans le menu du haut, cliquez sur VM puis Guest puis Install/Upgrade VMware Tools \n $neutre"
echo "deb http://ftp.debian.org/debian/ stretch main contrib non-free" >> /etc/apt/sources.list
apt-get update
apt-get upgrade -y
apt-get install net-tools -y	
apt-get install autoconf -y
apt-get install gcc-4.3* -y
apt-get install make -y
apt-get install psmisc -y
apt-get install linux-headers-$(uname -r) -y
apt-get install open-vm-tools -y
echo -e "$vertclair
Vous allez maintenant sélectionner Machine virtuelle / Installer VMware Tools puis monter le cdrom virtuel si ce n’est pas fait automatiquement. $neutre"
#si le cd ne se monte pas !
#mount /media/cdrom
cp -R /media/cdrom/VMwareTools-*.tar.gz /usr/local/src
umount /dev/cdrom
cd /usr/local/src
tar xzf /usr/local/src/VMwareTools-*.tar.gz
cd /usr/local/src/vmware-tools-distrib/
./vmware-install.pl -d -y
red_err "Redémarrage" "Un redémarrage va être appliqué !"
reboot
