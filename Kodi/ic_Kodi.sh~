
#/bin/bash

#	Script permettant:
#	1- D'automatiser l'installation de Kodi.
#----------------------------------------------------------------#
# Usage: ./ic_Kodi.sh
#	Exécuter le script en root!
#
# daniel.massy91@gmail.com
#
# Sources: https://kodi.wiki/view/Main_Page
#----------------------------------------------------------------#

# Mise à jour
apt-get update
apt-get upgrade

# Installation de Kodi
apt-get install kodi

# Installations des addon
apt-get install kodi-eventclients*
apt-get install kodi-pvr-*
apt-get install vdr-plugin-vnsiserver*

# Installation de dépendances
apt-get install libfftw3-bin
apt-get install libfftw3-dev
apt-get install python-pil-doc
apt-get install python-pil-dbg

# configurations
echo -e "\n Fin du script lancement de la page web d'aide si besoin ! \n" 
firefox https://box-android.tv/comment-bien-configurer-kodi-guide-complet/
