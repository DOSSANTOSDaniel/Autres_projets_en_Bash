#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name:	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date:                                             
# Version: 1.0                                      
# Bash_Version:                                     
#--------------------------------------------------#
# Description:                                      
#                                                   
#                                                   
# Options:                                          
#                                                   
# Usage:                                            
#                                                   
# Limits:                                           
#                                                   
# Licence:                                          
#--------------------------------------------------#

set -eu

### Includes ###

### Constants ###

### Fonctions ###

funEnvoi()
{
	utiliser mon script de copy !!!!
}

funOVA()
{
	echo "Convertir un fichier OVA"
	# Voir et extraire l'archive
	tar -tf xxxx.ova
	tar -xvf xxxx.ova
	# voir la description de la machine (cat OVF)
	# Convertion des disques
	qemu-img convert -O qcow2 xxxx-disk1.vmdk xxxx.qcow2
	# Création d'une nouvelle machine virtuelle selons l'OVF
	# Intégrer le disque sur la vm proxmox
	# déplacer le disque dans le dossier de la VM (/var/lib/vz/images/numero de la VM)
	# Je note le nom du disque vm-numero-disk-1.qcow2 et je supprime ce fichier. Enfin je renomme le fichier que l’on a importé.
}

funVMDK()
{
	echo "Convertir un fichier VMDK"
	# envoyer le disque vmdk sur le serveur
	# scp
	# ssh
	# winscp
	# rsync
	
	# Convertion des disques de vmdk vers qcow2
	qemu-img convert -f vmdk -O qcow2 hdd.vmdk hdd.qcow2
	# controle de l'image obtenu
	qemu-img check mondisque.qcow
	# -f : Format source
	# -O : Format de destination
	# hdd.vmdk : Chemin du disque dur virtuel VMDK à convertir
	# hdd.qcow2 ; Chemin du disque dur virtuel converti au format QCOW2
	# Création d'une nouvelle machine virtuelle selon l'ancienne
	# Intégrer le disque sur la vm proxmox
	#déplacer le disque dans le dossier de la VM (/var/lib/vz/images/numero de la VM)
	#Je note le nom du disque vm-numero-disk-1.qcow2 et je supprime ce fichier. Enfin je renomme le fichier que l’on a importé.
}

funVDI()
{
	echo "Convertir un fichier VDI"
	# envoyer le disque vdi sur le serveur
	# scp, ssh, winscp, rsync

	# Conversion des disques de vdi vers qcow2
	apt-get install qemu-utils

	qemu-img convert -c -f vdi mondisque.vdi -O qcow2 mondisque.qcow

	# controle de l'image obtenu
	qemu-img check mondisque.qcow

	# Création d'une nouvelle machine virtuelle selon l'ancienne

	# Intégrer le disque sur la vm proxmox
	# déplacer le disque dans le dossier de la VM (/var/lib/vz/images/numero de la VM)
	# Je note le nom du disque vm-numero-disk-1.qcow2 et je supprime ce fichier. Enfin je renomme le fichier que l’on a importé.
}

### Global variables ###

### Main ###

apt-get install qemu-utils


echo -e "Conversion VM vers Proxmox \n"
while [ : ]
do
	echo -e "\nConvertir un fichier OVA [O]"
	echo "Convertir un fichier VMDK [K]"
	echo -e "Convertir un fichier VDI [I] \n"
	
	read -p "Quel est votre choix : " typedisk
	echo ""

case $typedisk in
  [Oo0]) funOVA
		break;;
  [kK]) funVMDK
		break;;
  [Ii]) funVDI
		break;;
  *) echo "Erreur de PARAMETRES !"
esac
done

