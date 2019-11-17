#!/bin/bash
pacman -Syyu
pacman -S snapd
systemctl enable --now snapd.socket
pacman -S flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
