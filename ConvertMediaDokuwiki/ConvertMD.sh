#!/bin/bash

#================================================================#
# DESCRIPTION:
# Ce script va nous permettre de convertir plusieurs types de
# fichiers audios en OGG et aussi plusieur types de fichiers vidéo
# en MP4.
#----------------------------------------------------------------#
# AUTEURS:
#  Daniel DOS SANTOS < daniel.massy91@gmail.com >
#----------------------------------------------------------------#
# DATE DE CRÉATION: 24/10/2020
#----------------------------------------------------------------#
# USAGE: ./ConvertMD.sh
#----------------------------------------------------------------#
# NOTES:
# Le choix des fichiers de sortie :
#   1. MP3 pour l'audio
#   2. MP4 pour la vidéo
#----------------------------------------------------------------#
# BASH VERSION: GNU bash 5.0.17
#================================================================#

cat << "EOF"
	 ____        _           ____                          _            
	|  _ \  ___ | | ___   _ / ___|___  _ ____   _____ _ __| |_ ___ _ __ 
	| | | |/ _ \| |/ / | | | |   / _ \| '_ \ \ / / _ \ '__| __/ _ \ '__|
	| |_| | (_) |   <| |_| | |__| (_) | | | \ V /  __/ |  | ||  __/ |   
	|____/ \___/|_|\_\\__,_|\____\___/|_| |_|\_/ \___|_|   \__\___|_|   
                                                                    
EOF

sudo apt  install ffmpeg

### Fonctions ###

video_one()
{
declare -i count='1'

chemin="${1}"

while :
do
  section=$(echo "${chemin}" | cut -d '.' -f${count})
  if [[ -z ${section} ]]
  then
    break
  fi
  (( count++ ))
done

(( count-- ))

ext_file=$(echo "${chemin}" | cut -d '.' -f${count})

file=$(echo ${chemin} | sed "s/${ext_file}//g")
ffmpeg -nostdin -i ${1} -c:v copy -c:a copy -y ${file}mp4
sleep 5
}

video_all()
{
declare -i count_zero="0"
readonly total_cout="$(ls ${1} | wc -l)"

cd ${1}

for i in $(ls ${1})
do

  declare -i count='1'

  chemin="${i}"

  while :
  do
    section=$(echo "${i}" | cut -d '.' -f${count})
    if [[ -z ${section} ]]
    then
      break
    fi
    (( count++ ))
  done

  (( count-- ))

  ext_file=$(echo "${chemin}" | cut -d '.' -f${count})

  file=$(echo ${i} | sed "s/${ext_file}//g")
  ((cout_zero++))
  echo "Fichiers : ${cout_zero} / ${total_cout}"
  ffmpeg -nostdin -i ${i} -c:v copy -c:a copy -y ${file}mp4
  sleep 5
done
}

audio_one()
{
declare -i count='1'

chemin="${1}"

while :
do
  section=$(echo "${chemin}" | cut -d '.' -f${count})
  if [[ -z ${section} ]]
  then
    break
  fi
  (( count++ ))
done

(( count-- ))

ext_file=$(echo "${chemin}" | cut -d '.' -f${count})

file=$(echo ${chemin} | sed "s/${ext_file}//g")
ffmpeg -nostdin -i ${1} ${file}mp3
sleep 5
}

audio_all()
{
declare -i count_zero="0"
readonly total_cout="$(ls ${1} | wc -l)"

cd ${1}

for i in *
do
  declare -i count='1'

  chemin="${i}"

  while :
  do
    section=$(echo "${chemin}" | cut -d '.' -f${count})
    if [[ -z ${section} ]]
    then
      break
    fi
    (( count++ ))
  done

  echo "XXXXXXXXXXXXXXXXXXXXXXXX  ${chemin}  XXXXXXXXXXXXX"
  (( count-- ))

  ext_file=$(echo "${chemin}" | cut -d '.' -f${count})

  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${ext_file} XXXXXXXXXXXXX"
  file=$(echo ${chemin} | sed "s/${ext_file}//g")

  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  (( cout_zero++ ))
  echo "Fichiers : ${cout_zero} / ${total_cout}"

  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  echo "XXXXXXXXXXX ${chemin}XXXXXXXXXXXXX  ${file} XXXXXXXXXXXXX"
  ffmpeg -nostdin -i ${chemin} ${file}mp3
  sleep 5
done
}

file_exist()
{
if [ -z $1 ]
then
	echo -e "\n Le champ est vide, veuillez insserer un chemin valide \n"
	stopp
else
	if [ -e $1 ]
	then	
		if [ -f $1 ]
		then
			echo -e "\n Le chemin est correcte ! \n"
		else
			echo ""
		fi
	else
		echo -e "\n Le fichier n'existe pas !, ou c'est une erreur de syntax ! \n"
		stopp
	fi
fi
}

dir_exist()
{
if [ -z $1 ]
then
        echo -e "\n Le champ est vide, veuillez insserer un chemin valide \n"
        stopp
else
        if [ -e $1 ]
        then
                if [ -d $1 ]
                then
                        echo -e "\n Le chemin est correcte ! \n"
                else
                        echo ""
                fi
        else
                echo -e "\n Le dossier n'existe pas !, ou c'est une erreur de syntax ! \n"
                stopp
        fi
fi
}

stopp()
{
	echo ""
	read -p "Voulez vous convertir un autre fichier ? [o] oui [n] non : " fin
	echo ""
	case $fin in
	[oO]|"oui"|"OUI")
		continue;;
	[nN]|"non"|"NON")
		fin;;
	*)
		if [ -z $fin ]
		then
			echo "Le champ est vide, Veuillez insserer un choix valide"
			stop
		else
			echo "Probleme de syntax, Veuillez insserer un choix valide"
			stop
		fi;;
	esac
}

fin()
{
	clear
	echo -e "\n < FIN DU SCRIPT ! > \n"
	exit 0
}

while :
do	
	echo -e "\n \t Médias pris en charge : "
	cat << "EOF"
	
		+--------+----------------+
		| Image  | gif, jpg, png  |
		+--------+----------------+
		| Vidéo  | webm, ogv, mp4 |
		+--------+----------------+
		| Audio  | ogg, mp3, wav  |
		+--------+----------------+
		| Flash  | swf            |
		+--------+----------------+
EOF

	echo -e "\n \t Quel type de média voulez vous convertir : "
	read -p "[1] Vidéo, [2] Audio : " choix_un

	echo -e "\n \t Convertion par lots ou fichier par fichier ?"
	read -p "[1] un seul fichier, [2] par lots de fichiers : " choix_deux
	
	case $choix_un in
	1) echo -e "\n Mode Vidéo \n"
		if [[ ${choix_deux} == '1' ]]
		then
		  read -p "Chemin du fichier a convertir : " media
		  file_exist $media
		  video_one $media
		  stopp
		else
		  read -p "Chemin du dossier : " media
		  dir_exist $media
		  video_all $media
		  stopp
		fi
	;;
	2) echo -e "\n Mode Audio \n"
                if [[ ${choix_deux} == '1' ]]
                then
                  read -p "Chemin du fichier a convertir : " media
		  file_exist $media
                  audio_one $media
                  stopp
                else
                  read -p "Chemin du dossier : " media
		  dir_exist $media
                  audio_all $media
                  stopp
                fi
	;;
	3) echo -e "\n Mode Vidéo vers audio \n"
                convertAudio $media
                stopp
        ;;
	*) echo "ERREUR DE PARAMETRES !"
		stopp
	esac
done
