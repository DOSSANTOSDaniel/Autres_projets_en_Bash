#!/bin/bash

# Variables
userdlna="chayan"
intnet="eno1"
banniere="Serveur DLNA Olivier"
videos="VIDEO"
images="PHOTO"
musiques="AUDIO"

apt install toilet -y
sleep 2
toilet -f smblock --filter metal 'MiniDLNA'

apt update
apt full-upgrade -y
apt install ffmpeg -y
apt install libdlna0 -y
apt install pulseaudio-dlna -y
apt install minidlna -y

usermod -G minidlna $userdlna

echo "
user=$userdlna
media_dir=V,/home/$userdlna/$videos
media_dir=P,/home/$userdlna/$images
media_dir=A,/home/$userdlna/$musiques
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

ss -ratp
