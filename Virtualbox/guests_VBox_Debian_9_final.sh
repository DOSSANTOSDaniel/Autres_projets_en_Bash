#!/bin/bash

# TITRE: Additions invités VirtualBox Debian 9
#================================================================#
# DESCRIPTION:
#  Installation des additions invité sur une machine virtuelle
#  sous Debian 9.4
#----------------------------------------------------------------#
# AUTEURS:
#  Daniel DOS SANTOS < danielitto91@gmail.com >
#----------------------------------------------------------------#
# DATE DE CRÉATION: 27/05/2018
#----------------------------------------------------------------#
# VERSIONS: 1.0.0
#----------------------------------------------------------------#
# USAGE: ./guests_VBox_Debian_9.sh
#----------------------------------------------------------------#
# NOTES:
#  Outils utilisés VirtualBox 5.2, Debian 9, machine Phisique Debian 9.4
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
apt install screenfetch -y
clear
screenfetch
sleep 3
apt upgrade -y
apt dist-upgrade -y
aptitude install bzip2 -y
apt-get install tkdnd -y

#___Installation de paquets
apt install make -y
apt install gcc -y
apt install dkms -y
apt install build-essential -y
apt install module-assistant -y
apt install linux-source -y
apt install linux-headers-amd64 -y
apt install linux-headers-$(uname -r) -y
apt-get install virtualbox-guest-* -y
m-a prepare
useradd -u 2025 vboxsf
usermod -a -G vboxsf $(logname)

echo -e "$vertclair
Lancer le logiciel VirtualBox,
cliquer sur Périphériques > Insérer l'image CD des Additions invité\n 
$neutre"

read -p "Valider pour continuer"
cdrom=$(lsblk | grep rom | cut -d ' ' -f 1)
umount /dev/$cdrom
mkdir /tmp/vbox
mkdir /tmp/vboxinstall
mount /dev/$cdrom /tmp/vbox/
cp -R /tmp/vbox/* /tmp/vboxinstall/
umount /dev/$cdrom
cd /tmp/vboxinstall/
chmod +x VBoxLinuxAdditions.run
red_err "Attention" "Soyer attentifs aux logs suivants !"
bash VBoxLinuxAdditions.run
red_err "Redémarrage" "Un redémarrage va être appliqué !"
reboot
