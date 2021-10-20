#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name: install_vbox.sh	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date: dim. 19 sept. 2021 16:18:20                                             
# Version: 1.0                                      
# Bash_Version: 5.0.17(1)-release                                     
#--------------------------------------------------#
# Description:                                      
#                                                   
#                                                   
# Options:                                          
#                                                   
# Usage: ./install_vbox.sh                                            
#                                                   
# Limits:                                           
#                                                   
# Licence:                                          
#--------------------------------------------------#

set -eu

### Includes ###

### Constants ###

### Fonctions ###

### Global variables ###

username=

os_system=$(cat /etc/issue | cut -d ' ' -f1)

### Main ###

##### Import repository and gpg keys
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

##### Configure VirtualBox repository
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/"$os_system" $(lsb_release -cs) contrib non-free" | sudo tee /etc/apt/sources.list.d/virtualbox.list

##### Update apt repositories index
sudo apt update

##### Chose VirtualBox version

###### Menu
sudo apt-cache search virtualbox


##### Install VirtualBox version
sudo apt install virualbox-6.1 -y

##### Download Extension pack
wget https://download.virtualbox.org/virtualbox/6.1.26/Oracle_VM_VirtualBox_Extension_Pack-6.1.26-145957.vbox-extpack

##### Install Extension pack
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.26-145957.vbox-extpack

##### List Extensions 
sudo vboxmanage list extpacks

##### Add vboxusers group
sudo usermod -a -G vboxusers daniel

##### For Shared Folder feature
sudo usermod -a -G vboxsf daniel

ln  -s  /media/sf_partage_vbox/  /home/$(username)/Partage_VBox

echo -e "\n Dossier de partage : /home/$(username)/Partage_VBox"



