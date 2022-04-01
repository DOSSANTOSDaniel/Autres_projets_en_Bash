#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name: auto_update_ubuntu.sh	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date: sam. 08 mai 2021 20:48:09                                             
# Version: 1.0                                      
# Bash_Version: 5.0.17(1)-release                                     
#--------------------------------------------------#
# Description: Script permettant de mettre en place 
#              une stratégie de mise à jour automatique.
#                                                   
#                                                   
# Options:                                          
#                                                   
# Usage: ./auto_update_ubuntu.sh                                            
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

### Main ###

echo -e "\n Mises à jour automatiques \n"

echo -e "\n Installation des outils \n"
sudo apt update && sudo apt upgrade
sudo apt install unattended-upgrades apt-listchanges postfix bsd-mailx

echo -e "\n Configuration : /etc/apt/apt.conf.d/20auto-upgrades \n"
# Nettoyage des dépendances non utilisées
sudo sed -i '$ a APT::Periodic::AutocleanInterval "7";' /etc/apt/apt.conf.d/20auto-upgrades

echo -e "\n Configuration : /etc/apt/apt.conf.d/50unattended-upgrades \n"
# Configuration des mises à jour automatique
sudo sed -i 's#//\t"${distro_id}:${distro_codename}-updates"#\t"${distro_id}:${distro_codename}-updates"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Réparation automatique si dpkg rencontre un problème pendant une mise à jour
sudo sed -i 's#//Unattended-Upgrade::AutoFixInterruptedDpkg "true"#Unattended-Upgrade::AutoFixInterruptedDpkg "true"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Si le pc s’éteint pendant la mise à jour alors la mise à jour est reportée sans dégâts  
sudo sed -i 's#//Unattended-Upgrade::MinimalSteps "true"#Unattended-Upgrade::MinimalSteps "true"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Activation des notifications par mails en local (seulement les erreurs)
sudo sed -i 's#//Unattended-Upgrade::Mail ""#Unattended-Upgrade::Mail "daniel@iS3810"#' /etc/apt/apt.conf.d/50unattended-upgrades
sudo sed -i 's#//Unattended-Upgrade::MailReport "on-change"#Unattended-Upgrade::MailReport "only-on-error"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Suppression des anciens noyaux
sudo sed -i 's#//Unattended-Upgrade::Remove-Unused-Kernel-Packages "true"#Unattended-Upgrade::Remove-Unused-Kernel-Packages "true"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Suppression les dépendances non utilisées
sudo sed -i 's#//Unattended-Upgrade::Remove-Unused-Dependencies "false"#Unattended-Upgrade::Remove-Unused-Dependencies "true"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Si le système a besoin de redémarrer alors un avertissement s'affiche puis deux minutes après le système redémarre
sudo sed -i 's#//Unattended-Upgrade::Automatic-Reboot "false"#Unattended-Upgrade::Automatic-Reboot "true"#' /etc/apt/apt.conf.d/50unattended-upgrades
sudo sed -i 's#//Unattended-Upgrade::Automatic-Reboot-Time "02:00"#Unattended-Upgrade::Automatic-Reboot-Time "20:15"#' /etc/apt/apt.conf.d/50unattended-upgrades
 
# Permet si besoin de revenir à une version précèdente
sudo sed -i 's#// Unattended-Upgrade::Allow-downgrade "false"# Unattended-Upgrade::Allow-downgrade "true"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Envoi les messages dans syslog
sudo sed -i 's#// Unattended-Upgrade::SyslogEnable "false"# Unattended-Upgrade::SyslogEnable "true"#' /etc/apt/apt.conf.d/50unattended-upgrades

# Permet de faire les mises à jour avec ou sans batterie
sudo sed -i 's#// Unattended-Upgrade::OnlyOnACPower "true"# Unattended-Upgrade::OnlyOnACPower "false"#' /etc/apt/apt.conf.d/50unattended-upgrades

echo -e "\n Test de la configuration de unattended-upgrades \n" 
sudo unattended-upgrades --dry-run --debug

echo -e "\n Configuration snaps \n"
sudo snap set system refresh.timer=6:00-8:00,12:00-14:00
sudo snap set system refresh.retain=2
