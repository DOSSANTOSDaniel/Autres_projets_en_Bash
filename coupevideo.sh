#!/bin/bash
#-*- coding: UTF8 -*-

#--------------------------------------------------#
# Script_Name:	                               
#                                                   
# Author:  'dossantosjdf@gmail.com'                 
# Date:                                             
# Version: 1.0                                      
# Bash_Version:                                     
#--------------------------------------------------#
# Description: Découpe un fichier vidéo en deux parties
#              utilile si on veut mettre un fichier
#              vidéo de plus de 4go dans notre clé USB.  
#                                                   
# Options:                                          
#                                                   
# Usage:                                            
#                                                   
# Limits:    pas plus de 8go                                       
#                                                   
# Licence:                                          
#--------------------------------------------------#

set -eu

### Includes ###

### Constants ###

### Fonctions ###

### Global variables ###

dir_video="${1}"

taille_video=$(du -sh "${dir_video}" | cut -f1 | sed -re 's/G//' | sed -re 's/,/./')

taille_coupe=$(echo "${taille_video}/2" | bc -l)

taille_coupe=$(echo "${taille_coupe}*1024" | bc | cut -d'.' -f1)

nom_film_source=$(basename "${dir_video}")

nom_film=$(echo "${nom_film_source}" | cut -d'.' -f1)

ext_film=$(echo "${nom_film_source}" | cut -d'.' -f2)

### Main ###

echo " Début du script "

mkvmerge -o "${nom_film}vd.${ext_film}" --split "${taille_coupe}"M "${nom_film_source}"

mv "${nom_film_source}" "${nom_film_source}".bak

echo "Fin du script"


