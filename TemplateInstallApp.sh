#!/bin/bash

# Description:
#	Permet l'installation de mes applications
#----------------------------------------------------------------#
# Usage: ./InstallGUIAppExtra.sh
#	Exécuter le script en root!
#
# Auteurs:
#  	Daniel DOS SANTOS < daniel.massy91@gmail.com >
#----------------------------------------------------------------#

### Installation

# variables
usertos=$(w | awk '{print $1}' | awk 'NR==3')
interfacewifi=$(ip link | grep ^3 | awk '{print $2}' | sed s'/://')
interfacenet=$(ip link | grep ^2 | awk '{print $2}' | sed s'/://')
liste=$(apt list | grep libreoffice-l10n-* | awk -F'/' '{print $1}')
chem="/etc/apt/apt.conf.d/50unattended-upgrades"

# Configuration des mises à jours automatiques
apt install unattended-upgrades -y
apt install apt-listchanges -y
dpkg-reconfigure -plow unattended-upgrades
# activer les mises à jours en fonction des types de paquets, stable, proposed-udpates, security
sed -i -e 's/\/\/      "${distro_id}:${distro_codename}-updates";/      "${distro_id}:${distro_codename}-updates";/' $chem
sed -i -e 's/\/\/      "${distro_id}:${distro_codename}-proposed";/      "${distro_id}:${distro_codename}-updates";/' $chem
# activer les notifications par mail
sed -i -e 's/\/\/Unattended-Upgrade::Mail "root";/Unattended-Upgrade::Mail "danielitto91@gmail.com";/' $chem
# activer le redémarrage après mise à jour
sed -i -e 's/\/\/Unattended-Upgrade::Automatic-Reboot "false";/Unattended-Upgrade::Automatic-Reboot "true";/' $chem
# heure du redémarrage
sed -i -e 's/\/\/Unattended-Upgrade::Automatic-Reboot-Time "02:00";/Unattended-Upgrade::Automatic-Reboot-Time "20:18";/' $chem
# mise à jour maintenant
unattended-upgrades -v

# installation de simplenote
wget https://github.com/Automattic/simplenote-electron/releases/download/v1.10.0/Simplenote-linux-1.10.0-amd64.deb
apt install gconf2 -y
dpkg -i Simplenote-linux-1.10.0-amd64.deb
sleep 1
rm Simplenote-linux-1.10.0-amd64.deb

# installation de etcher
apt install zenity -y
echo "deb https://deb.etcher.io stable etcher" | tee /etc/apt/sources.list.d/balena-etcher.list
sleep 1
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
apt update
apt install balena-etcher-electron -y

# Installation d'AnyDesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
sleep 1
apt update
apt install anydesk -y

# Installation de Wireshark
apt install wireshark -y
usermod -a -G wireshark "$usertos"
chgrp wireshark /usr/bin/dumpcap
chmod 771 /usr/bin/dumpcap
setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
ip link set "$interfacenet" promisc on
ip link set "$interfacewifi" promisc on

# Installation de Visual Studio Code
wget http://packages.microsoft.com/repos/vscode/pool/main/c/code/code_1.40.1-1573664190_amd64.deb
apt install ./code_1.40.1-1573664190_amd64.deb -y
sleep 1
rm code_1.40.1-1573664190_amd64.deb
code --install-extension timonwong.shellcheck

# installation de google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
echo "
### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
" > /etc/apt/sources.list.d/google-chrome.list
apt update && apt upgrade -y
rm google-chrome-stable_current_amd64.deb

# Installation de LibreOffice
apt install libreoffice -y
apt install libreoffice-voikko -y
apt install openclipart-libreoffice -y
wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb
apt install ./ttf-mscorefonts-installer_3.7_all.deb -y
wget https://grammalecte.net/grammalecte/oxt/Grammalecte-fr-v1.5.0.oxt
rm ttf-mscorefonts-installer_3.7_all.deb
apt install ttf-mscorefonts-installer -y
for pack in $liste
do
	if [[ $pack == "libreoffice-l10n-fr" || $pack == "libreoffice-l10n-en-gb" ]]
	then
	        echo "$pack"
	else
	        apt-get remove $pack
	fi
done

# Installation de Teamviewer
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
dpkg -i teamviewer_amd64.deb
apt install -f

# Installation de Redshift
apt-get install redshift
# pour trouver l'affichage courant
ecran=$(xrandr | grep Screen | awk '{print $2}' | awk -F: '{print $1}')
echo "
; Global settings for redshift
[redshift]
; Set the day and night screen temperatures
temp-day=3000
temp-night=3000
; Enable/Disable a smooth transition between day and night
; 0 will cause a direct change from day to night screen temperature.
; 1 will gradually increase or decrease the screen temperature.
transition=1
; Set the screen brightness. Default is 1.0.
;brightness=0.9
; It is also possible to use different settings for day and night
; since version 1.8.
;brightness-day=0.7
;brightness-night=0.4
; Set the screen gamma (for all colors, or each color channel
; individually)
gamma=0.8
;gamma=0.8:0.7:0.8
; This can also be set individually for day and night since
; version 1.10.
;gamma-day=0.8:0.7:0.8
;gamma-night=0.6
; Set the location-provider: 'geoclue', 'geoclue2', 'manual'
; type 'redshift -l list' to see possible values.
; The location provider settings are in a different section.
location-provider=manual
; Set the adjustment-method: 'randr', 'vidmode'
; type 'redshift -m list' to see all possible values.
; 'randr' is the preferred method, 'vidmode' is an older API.
; but works in some cases when 'randr' does not.
; The adjustment method settings are in a different section.
adjustment-method=randr
; Configuration of the location-provider:
; type 'redshift -l PROVIDER:help' to see the settings.
; ex: 'redshift -l manual:help'
; Keep in mind that longitudes west of Greenwich (e.g. the Americas)
; are negative numbers.
[manual]
lat=48.1
lon=11.6
; Configuration of the adjustment-method
; type 'redshift -m METHOD:help' to see the settings.
; ex: 'redshift -m randr:help'
; In this example, randr is configured to adjust screen 1.
; Note that the numbering starts from 0, so this is actually the
; second screen. If this option is not specified, Redshift will try
; to adjust _all_ screens.
[randr]
screen=$ecran
" > /home/"$usertos"/.config/redshift.conf

# Autres programmes
apt install vlc -y
apt install filezilla -y
apt install gdebi -y
apt install gedit -y
apt install gparted -y
apt install diodon -y
apt install nextcloud-desktop -y
apt install zenmap -y
apt install keepassx -y
apt install rhythmbox -y
apt install gnome-connection-manager -y
apt install git -y
apt install nwipe -y
apt install fslint -y

# nettoyage du système
apt autoremove --purge -y
apt autoclean

systemctl reboot
