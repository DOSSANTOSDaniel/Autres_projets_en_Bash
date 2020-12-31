#!/bin/bash

# TITRE: Découverte réseau			
#================================================================#
# DESCRIPTION:
#	
#================================================================#
# AUTEUR: Daniel DOS SANTOS < daniel.massy91@gmail.com >			
#================================================================#
# DATE DE CREATION: 03/11/2020	
#================================================================#
# VERSION INITIALE: V.1.0
#================================================================#   
# USAGE: ./scanetwork.sh
# En root !
#================================================================#
# NOTES: 
#
#================================================================#
# Bash VERSION: 
#================================================================#

# Fonctions
messages()
{
	echo -e "\n\n\n\n #########################################################################"
	echo " Scan des $1 "
	echo -e "######################################################################### \n"
}

intmes()
{
        echo -e "\n\n ------------------------------------------------------------------------------"
	echo " $1 "
        echo -e "------------------------------------------------------------------------------ \n"
}

# Variables
fichiers="Scan_$(date +%T)"

nbipup=0

nbipdown=0

interfacenet=$(ip link | grep ^2 | awk '{print $2}' | sed s'/://')

# Installations
apt install figlet -qqqy
apt install arp-scan -qqqy
apt install nbtscan -qqqy

# Programme principale
touch $fichiers
clear
figlet -c 'S u p e r  S c a n' | tee -a $fichiers

messages 'machines sur le réseau [Scan Nmap]' >> $fichiers
nmap -sP 192.168.0.0/24 -T5 >> $fichiers

messages 'machines sur le réseau [Scan ARP]' >> $fichiers
arp-scan --interface=$interfacenet --localnet >> $fichiers

messages 'noms de machines dans le réseau' >> $fichiers
nbtscan -v 192.168.0.0/24 >> $fichiers

for ii in 192.168.0.{1..254}
do
	if ping -c 1 $ii
	then
		messages "ports ouverts, os et autres infos sur l'ordinateur $ii" >> $fichiers
                figlet -f big -c $ii >> $fichiers
		nbipup=$(($nbipup+1))
		intmes "Scan ports" >> $fichiers
                nmap -sV -p- $ii -T5 >> $fichiers
		intmes "Scan autres infos" >> $fichiers
		nmap -sO $ii -T5 >> $fichiers
		intmes "Scan NetBios" >> $fichiers
		nmblookup -A $ii >> $fichiers
	else
		nbipdown=$(($nbipdown+1))
	fi
done

echo -e "\n\n FIN DU SCAN \n" >> $fichiers
echo "Machines UP : $nbipup" >> $fichiers
echo "Machines DOWN : $nbipdown" >> $fichiers
