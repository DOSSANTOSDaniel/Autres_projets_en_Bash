#!/bin/bash

# Variables
userdlna="root"
pathdlna="/home/Partage"
intnet="eth0@if9"
banniere="Serveur DLNA Olivier"
videos="VIDEO"
images="PHOTO"
musiques="AUDIO"
books="BOOK"

sudo apt install toilet -y > /dev/null
sleep 1
clear
toilet -f smblock --filter metal 'MiniDLNA'
echo -e "\n"

sudo apt update
sudo apt full-upgrade -y
sudo apt install ffmpeg -y
sudo apt install libdlna0 -y
sudo apt install pulseaudio-dlna -y
sudo apt install minidlna -y

sudo usermod -a -G minidlna $userdlna

mkdir -p /home/Partage/{PHOTO,VIDEO,AUDIO}
sleep 1
mkdir /var/log/dlna
sudo chown -R minidlna:minidlna /var/log/dlna
sleep 1

echo "
user=$userdlna

media_dir=V,${pathdlna}/${videos}
media_dir=P,${pathdlna}/${images}
media_dir=A,${pathdlna}/${musiques}

db_dir=/var/cache/minidlna

log_dir=/var/log/dlna

#Définir une racine de l'arborescence des répertoires présentée sur les machines clientes
#   * "." - standard container
#   * "B" - "Browse Directory"
#   * "M" - "Music"
#   * "P" - "Pictures"
#   * "V" - "Video"
root_container=B

port=8200

network_interface=$intnet

# Nom réseau
friendly_name=$banniere

# Détection automatique des nouveaux fichiers.
inotify=yes

album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg
album_art_names=AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg
album_art_names=Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg

enable_tivo=no

strict_dlna=no

#Délai de mise à jour de l'indexation des fichiers
notify_interval=30

max_connections=5

" > /etc/minidlna.conf

sleep 2

systemctl restart minidlna

sleep 1

systemctl status minidlna

clear

ss -lntp

# minidlna -R ---> Scanner et indexer les fichiers multimédia dans la base du serveur UPNP/DLNA
