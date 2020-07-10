#!/bin/bash

# TITRE: Additions pour Debian
#================================================================#
# DESCRIPTION:

#================================================================#
# AUTEURS:
#  Daniel DOS SANTOS < danielitto91@gmail.com >
#================================================================#
# LICENCE: CC BY-SA 4.0
#  This work is licensed under 
#  the Creative Commons Attribution-ShareAlike 4.0 International License.
#  To view a copy of this license,visit 
#  http://creativecommons.org/licenses/by-sa/4.0/ 
#  or send a letter to 
#  Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
#================================================================#
# DATE DE CRÉATION: 20/05/2018
#================================================================#
# VERSIONS:
# 20/05/2018
#  Création des fonctions. 
# 21/05/2018
#  Teste et validation pour Debian 8 sur VirtualBox. 
#================================================================#
# USAGE: ./additions_guests.sh
#================================================================#
# NOTES:
#
#  
#================================================================#
# BASH VERSION: GNU bash 4.4.12
#================================================================#

#___Déclaration des variables de couleur
vertclair='\e[1;32m'
orange='\e[0;33m'
jaune='\e[1;33m'
neutre='\e[0;m'
bleuclair='\e[1;34m'
rougefonce='\e[0;31m'

#___LES FONCTIONS___
function versions_debian
	{
	echo -e "\n\n"
	echo -e "$jaune\t\t Versions de Debian$neutre"
	echo -e "$vertclair\t\t<=================>$neutre"
	echo -e "\t\t| Stretch  9  $rougefonce[9]$neutre |"
	echo -e "$vertclair\t\t-------------------$neutre"
	echo -e "\t\t| Jessie   8  $rougefonce[8]$neutre |"
	echo -e "$vertclair\t\t-------------------$neutre"
	echo -e "\n Quelle est la version de votre machine virtuelle ? \n"
	read -p "Votre choix 8 ou 9 ==> " -n 1 deb
	}

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

# Bannière du script
function ban
        {
        for couleur in "$vertclair" "$orange" "$jaune" "$bleuclair" "$rougefonce"
        do
                clear
                echo -e "$couleur
		__     ___      _               _ _           _   _             
		\ \   / (_)_ __| |_ _   _  __ _| (_)___  __ _| |_(_) ___  _ __  
		 \ \ / /| | '__| __| | | |/ _° | | / __|/ _° | __| |/ _ \| '_ \ 
		  \ V / | | |  | |_| |_| | (_| | | \__ \ (_| | |_| | (_) | | | |
		   \_/  |_|_|   \__|\__,_|\__,_|_|_|___/\__,_|\__|_|\___/|_| |_|
				                                                

				  Installation des additions invités       
				 <=================================>        
				 |                |                |
				 |     VMware     |    VirtualBox  |
				 |                |                |
				 -----------------------------------
				 |                                 |
				 | Sous DEBIAN 8 Jessie / 9 stretch|
				 |                                 |
				 -----------------------------------
      .___.
     /     \\
    | O _ O |
    /  \\_/  \\
  .' /     \\ °.
 / _|       |_ \\
(_/ |       | \\_)
    \\       /
   __\\_>-<_/__
   ~;/     \\;~
                $neutre"
                sleep 1
	done
        }

#__Bannière
ban
sleep 1

#___Mises à jour et autres paquets globales
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install screenfetch -y
aptitude install bzip2 -y
sleep 3
clear
screenfetch
echo -e "\n"
echo -e "\t  ________________________________________________ "
echo -e "\t /                                                \\"
echo -e "\t |                Message important               |"
echo -e "\t |               -------------------              |"
echo -e "\t |                                                |"
echo -e "\t |   Avant de continuer vérifier que vous avez    |"
echo -e "\t |   bien installé les suppléments invités pour   |"
echo -e "\t |   les logiciels de virtualisation.             |"
echo -e "\t \________________________________________________/"
echo -e "\n"
read -p " Vous êtes sous VMware[V] ou VirtualBox[B] ? " -n 1 logi
clear

if [ $logi = "V" ] || [ $logi = "v" ]
then
	versions_debian
	case $deb in
	9) #Installation de Debian 9 Stretch
	echo -e "$vertclair \n Dans le menu du haut, cliquez sur VM puis Guest puis Install/Upgrade VMware Tools \n $neutre"
	echo "deb http://ftp.debian.org/debian/ stretch main contrib" >> /etc/apt/sources.list
	apt-get update
	apt-get upgrade -y
	apt-get install open-vm-tools -y
	apt-get install net-tools -y	
	apt-get install autoconf -y
	apt-get install gcc-4.3* -y
	apt-get install make -y
	apt-get install psmisc -y
	apt-get install linux-headers-$(uname -r) -y
	echo -e "$vertclair
	Vous allez maintenant sélectionner Machine virtuelle / Installer VMware Tools puis monter le cdrom 		virtuel si ce n’est pas fait automatiquement. $neutre"
	#si le cd ne se monte pas !
	#mount /media/cdrom
	cp -R /media/cdrom/VMwareTools-*.tar.gz /usr/local/src
	umount /dev/cdrom
	cd /usr/local/src
	tar xzf /usr/local/src/VMwareTools-*.tar.gz
	cd /usr/local/src/vmware-tools-distrib/
	./vmware-install.pl -d -y
	red_err "Redémarrage" "Un redémarrage va être appliqué !"
	reboot ;;

	8) #Installation de Debian 8 Jessie
	echo -e "$vertclair
	Vous allez maintenant sélectionner Machine virtuelle / Installer VMware Tools puis monter le cdrom 		virtuel si ce n’est pas fait automatiquement. $neutre"
	echo "deb http://ftp.debian.org/debian/ jessie main contrib" >> /etc/apt/sources.list
	apt-get update
	apt-get upgrade -y
	apt-get install open-vm-tools -y
	apt-get install autoconf -y
	apt-get install gcc-4.3* -y
	apt-get install make -y
	apt-get install psmisc -y
	apt-get install linux-headers-$(uname -r) -y

	#si le cd ne se monte pas !
	#mount /media/cdrom
	cp -R /media/cdrom/VMwareTools-*.tar.gz /usr/local/src
	umount /dev/cdrom
	cd /usr/local/src
	tar xzf /usr/local/src/VMwareTools-*.tar.gz
	cd /usr/local/src/vmware-tools-distrib/
	./vmware-install.pl -d -y
	red_err "Redémarrage" "Un redémarrage va être appliqué !"
	reboot ;;
	*) red_err "ERREUR" "Le choix que vous avez fait n'est pas dans la liste!";;
	esac

elif [ $logi = "B" ] || [ $logi = "b" ]
then
	versions_debian
	case $deb in
	9) #Installation de Debian 9 Stretch
	echo -e "$vertclair il faut aller chercher le fichier téléchargé sur l'hôte
	dans le dossier Téléchargements
	Menu > Configuration > Stockage puis dans le lecteur optique virtuel charger le fichier 			VBoxGuestAdditions_5.1.30.iso et valider avec le bouton Ok $neutre"
	#___Installation de paquets
	apt install make -y
	apt install gcc -y
	apt install dkms -y
	apt install build-essential -y
	apt install module-assistant -y
	apt install linux-source -y
	apt install linux-headers-amd64 -y
	apt install linux-headers-$(uname -r) -y
	aptitude install virtualbox-guest-additions -y
	aptitude install virtualbox-guest-utils -y
	/etc/init.d/vboxadd setup
	m-a prepare
	echo -e "$vertclair
	Lancer le logiciel VirtualBox,
	cliquer sur Périphériques > Insérer l'image CD des Additions invité\n $neutre"
	read -p "Valider pour continuer"
	cdrom=$(lsblk | grep rom | cut -d ' ' -f 1)
	mkdir /tmp/vbox
	cp -R /media/$cdrom/* /tmp/vbox/
	cd /tmp/vbox/
	chmod +x VBoxLinuxAdditions.run
	red_err "Attention" "soyez attentifs aux logs suivants !"
	bash VBoxLinuxAdditions.run
	red_err "Redémarrage" "Un redémarrage va être appliqué !"
	reboot;;
	8) #Installation de Debian 8 Jessie
	#___Installation de paquets
	apt install make -y
	apt install gcc -y
	apt install dkms -y
	apt install build-essential -y
	apt install module-assistant -y
	apt install linux-source -y
	apt install linux-headers-amd64 -y
	apt install linux-headers-$(uname -r) -y
	/etc/init.d/vboxadd setup
	m-a prepare	
	echo -e "$vertclair \t
	Lancer le logiciel VirtualBox,
	cliquer sur Périphériques > Insérer l'image CD des Additions invité
	\n $neutre"
	read -p "Valider pour continuer"
	perso=$(w | grep tty* | cut -d ' ' -f 1)
	usermod -a -G vboxsf $perso
	cdrom=$(lsblk | grep rom | cut -d ' ' -f 1)
	mkdir /tmp/vbox
	mkdir /tmp/vbox_final
	mount /dev/$cdrom /tmp/vbox
	cp -R /tmp/vbox/* /tmp/vbox_final/
	umount /tmp/vbox
	rm -rf /tmp/vbox 
	cd /tmp/vbox_final/
	chmod +x VBoxLinuxAdditions.run
	red_err "Attention" "Soyer attentifs aux logs suivants !"
	bash VBoxLinuxAdditions.run
	red_err "Redémarrage" "Un redémarrage va être appliqué !"
	reboot ;;
	*) red_err "ERREUR" "Le choix que vous avez fait n'est pas dans la liste!";;
	esac	
else
	red_err "ERREUR" "Le choix que vous avez fait n'est pas dans la liste!"	
fi
