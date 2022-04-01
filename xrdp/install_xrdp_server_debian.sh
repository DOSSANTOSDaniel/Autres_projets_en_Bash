#!/bin/bash
# Source tuto : https://www.tecmint.com/install-xrdp-on-ubuntu/

clear
 
apt update && apt -y upgrade

# Ajout des modules hv_modules dans /etc/initramfs-tools/modules
echo 'hv_vmbus' >> /etc/initramfs-tools/modules
echo 'hv_storvsc' >> /etc/initramfs-tools/modules
echo 'hv_blkvsc' >> /etc/initramfs-tools/modules
echo 'hv_netvsc' >> /etc/initramfs-tools/modules

# kernel linux-virtual
apt install hyperv-daemons -y

read -p "Valider si OK!"

# Mise à jour de Initramfs
update-initramfs -u
 
# lignes a changer :
#unset DBUS_SESSION_BUS_ADDRESS
#unset XDG_RUNTIME_DIR

sudo apt install xrdp -y

sudo adduser xrdp ssl-cert

sudo sed -i '/^test/i unset DBUS_SESSION_BUS_ADDRESS' /etc/xrdp/startwm.sh
sudo sed -i '/unset DBUS_SESSION_BUS_ADDRESS/a unset XDG_RUNTIME_DIR' /etc/xrdp/startwm.sh 

sudo systemctl restart xrdp

sudo systemctl enable xrdp

echo
ip a
echo

echo "Vérification : Get-VMIntegrationService -vmname 'NameOfYourVM'"

read -p "Fin de la configuration, taper entrée pour reboot"

reboot










