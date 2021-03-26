#!/bin/bash
cd /tmp
wget https://github.com/ventoy/Ventoy/releases/download/v1.0.08/ventoy-1.0.08-linux.tar.gz
tar xzvf ventoy-1.0.08-linux.tar.gz
echo ""
echo "Tapez 1 pour installer"
echo "Tapez 2 pour mettre à jour"
echo "Tapez 3 pour réinstaller"
echo ""
read -p "Votre choix : " INST
if [ "$INST" == "1" ]
then
	lsblk
	read -p "Choisir disque : " CHOIX
	bash /tmp/ventoy-1.0.08/Ventoy2Disk.sh -i /dev/$CHOIX
elif [ "$INST" == "2" ]
then
	lsblk
	read -p "Choisir disque : " CHOIX
	bash /tmp/ventoy-1.0.08/Ventoy2Disk.sh -u /dev/$CHOIX
elif [ "$INST" == "3" ]
then
        lsblk
        read -p "Choisir disque : " CHOIX
        bash /tmp/ventoy-1.0.08/Ventoy2Disk.sh -I /dev/$CHOIX

else
	echo "Erreur de frappe"
fi
echo "Fin du script"

