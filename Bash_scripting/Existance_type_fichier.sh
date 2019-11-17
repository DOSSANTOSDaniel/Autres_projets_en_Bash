#!/bin/bash

# TITRE: Le fichier existe ?
#================================================================#
# DESCRIPTION:
# Ce script va nous permettre de savoir si un fichier saissie 
# par un utilisateur existe ou n'existe pas, il sera possible 
# aussi de savoir quel est son type parmis les types de fichiers 
# fichier, dossier, bloc, charactère et lien.
#----------------------------------------------------------------#
# AUTEURS:
#  Daniel DOS SANTOS < danielitto91@gmail.com >
#----------------------------------------------------------------#
# DATE DE CRÉATION: 07/07/2018
#----------------------------------------------------------------#
# USAGE: ./exo4_fichier.sh
#----------------------------------------------------------------#
# NOTES:
# Les differents testes intégré au script:
# Teste si un champ saissie par l'utilisateur est vide.
# Teste si l'utilisateur a saissie un champ valide.
# Teste si le fichier existe.
# Teste le type du fichier.
# Permet plusieurs combinaisons de saissies par l'utilisateur 
# exemple oui, o, O, OUI.
#----------------------------------------------------------------#
# BASH VERSION: GNU bash 4.4.12
#================================================================#

### Variables de couleurs ###
rouge='\e[0;31m' 
vert='\e[0;32m' 
orange='\e[0;33m' 
bleu='\e[0;34m'  
neutre='\e[0;m'

### Fonctions ###
function ban
{
	cat << "EOF"
 _____ _      _     _               
|  ___(_) ___| |__ (_) ___ _ __ ___ 
| |_  | |/ __| '_ \| |/ _ \ '__/ __|
|  _| | | (__| | | | |  __/ |  \__ \
|_|   |_|\___|_| |_|_|\___|_|  |___/
                                    
EOF
}

function error
{
        echo ""
        echo -e "${rouge} ERREUR ${neutre}"
        echo -e "${orange}-----------------------${neutre}"
        echo -e "${rouge} $1 ${neutre}"
        echo -e "${rouge} $2 ${neutre}"
		echo ""
}

function msg
{
  echo -e "${vert}||>${neutre} ${orange} $1 ${neutre}"
  echo -e "${vert}||>${neutre} ${orange} $2 ${neutre}"
}

function test
{
if [ -z $1 ]
	then
		error "Le champ est vide" "veuillez insserer un chemin valide"
		stop
else
	if [ -e $1 ]
	then	
		if [ -f $1 ]
		then
			echo ""
			msg "Le fichier existe !" " Il est de type fichier ordinaire !"
			if [ -L $1 ]
			then
				echo ""
				msg "C'est un lien symbolique !"
			else
				echo ""
			fi
		elif [ -d $1 ]
		then
			echo ""
			msg "Le fichier existe !" " Il est de type dossier !"
			if [ -L $1 ]
			then
				echo ""
				msg "Et c'est aussi un lien symbolique !"
			else
				echo ""
			fi
		elif [ -b $1 ]
		then
			echo ""
			msg "Le fichier existe et est de type bloc" "lecteur de disquettes, lecteur de cdroms, etc."
		elif [ -c $1 ]
		then
			echo ""
			msg "Le fichier existe et est de type caractère" "clavier, modem, carte son, etc..."
		else
			echo "$1"
			error "Le fichier existe et est d'un autre type !"
		fi
	else
		error "Le fichier n'existe pas !" "Ou c'est une erreur de syntax !"
		stop
	fi
fi
}

function stop
{
	echo ""
	read -p "Voulez vous tester un autre fichier ? [o] oui [n] non : " fin
	echo ""
	case $fin in
	[oO]|"oui"|"OUI")
		continue;;
	[nN]|"non"|"NON")
		fin;;
	*)
		if [ -z $fin ]
		then
			error "Le champ est vide" "Veuillez insserer un choix valide"
			stop
		else
			error "Probleme de syntax" "Veuillez insserer un choix valide"
			stop
		fi;;
	esac
}

function fin
{
	clear
	ban
	echo ""
	echo -e "${bleu}< FIN DU SCRIPT ! >${neutre}"
	echo ""
	exit 0
}

### Développement ###
while :
do
clear
ban
echo ""
read -p "Veuillez saisir le chemin du fichier : " fic
test $fic
stop
done