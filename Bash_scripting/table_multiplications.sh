#!/bin/bash

# TITRE: Tables de multiplications
#================================================================#
# DESCRIPTION: 
# Ce script a pour fonction d'afficher a l'écran la
# table de multiplication saisie par un utilisateur.
#----------------------------------------------------------------#
# AUTEURS: Daniel DOS SANTOS < danielitto91@gmail.com >
#----------------------------------------------------------------#
# DATE DE CRÉATION: 07/07/2018
#----------------------------------------------------------------#
# USAGE: ./exo3_multi.sh
#----------------------------------------------------------------#
# NOTES: 
# Les differents testes intégré au script:
# Teste si un champ saissie par l'utilisateur est vide.
# Teste si l'utilisateur a saissie un champ valide.
# Teste si c'est une valeur numérique.
# Teste si l'utilisateur a saisie plusieurs zeros et retien
# qu'un seul zero.
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
	 __  __       _ _   _       _ _           _   _
	|  \/  |_   _| | |_(_)_ __ | (_) ___ __ _| |_(_) ___  _ __  ___
	| |\/| | | | | | __| | '_ \| | |/ __/ _` | __| |/ _ \| '_ \/ __|
	| |  | | |_| | | |_| | |_) | | | (_| (_| | |_| | (_) | | | \__ \
	|_|  |_|\__,_|_|\__|_| .__/|_|_|\___\__,_|\__|_|\___/|_| |_|___/
	                     |_|
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

function stop
{
	echo ""
	read -p "Voulez vous voir une autre table ? oui [o] non [n] : " fin
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

function zero
{
	if [[ $multi =~ ^[^1-9]+$ ]]
	then
		multi=0
		echo "$multi"
	else
		echo ""
	fi
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
read -p "Choisisser votre table de multiplication : " multi
zero
if [[ $multi =~ ^[0-9]+$ ]] # regex le + une ou plusieurs occurences
then
  	echo ""
	echo -e "${rouge}Voici la table de [ $multi ] ${neutre}"
	echo ""
	echo -e "${orange}================= ${neutre}"
	for i in `seq 0 10`
	do
		echo "[$multi] X [$i] = [$(($multi * $i))]"
	done
		echo -e "${orange}================= ${neutre}"
		echo ""
else
  	error "La chaîne n'est pas numérique" "Veillez insserer une valeur numérique"
fi
echo ""
stop
done