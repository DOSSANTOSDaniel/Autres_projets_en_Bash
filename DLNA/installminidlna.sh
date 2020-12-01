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

apt install toilet -y > /dev/null
sleep 1
clear
toilet -f smblock --filter metal 'MiniDLNA'
echo -e "\n"

apt update
apt full-upgrade -y
apt install ffmpeg -y
apt install libdlna0 -y
apt install pulseaudio-dlna -y
apt install minidlna -y

usermod -G minidlna $userdlna

mkdir -p /home/Partage/{PHOTO,VIDEO,AUDIO,BOOK}
sleep 1
mkdir /var/log/dlna
sleep 1

echo "
user=$userdlna
media_dir=V,${pathdlna}/${videos}
media_dir=P,${pathdlna}/${images}
media_dir=A,${pathdlna}/${musiques}
db_dir=/var/cache/minidlna
log_dir=/var/log/dlna
port=8200
network_interface=$intnet
friendly_name=$banniere
inotify=yes
album_art_names=Cover.jpg/cover.jpg/AlbumArtSmall.jpg/albumartsmall.jpg
album_art_names=AlbumArt.jpg/albumart.jpg/Album.jpg/album.jpg
album_art_names=Folder.jpg/folder.jpg/Thumb.jpg/thumb.jpg
enable_tivo=no
strict_dlna=no
notify_interval=30
max_connections=5
" > /etc/minidlna.conf

sleep 2

systemctl restart minidlna

sleep 1

systemctl status minidlna

clear

ss -lntp

