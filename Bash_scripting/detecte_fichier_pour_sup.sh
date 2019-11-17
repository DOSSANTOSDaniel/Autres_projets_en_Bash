#!/bin/bash

function testy
{
if [ $1 "$chemin/$i" ]
then
	rm -rf "$chemin/$i"
	if [ "$?" == "0" ]
	then
		echo "-------------"
		echo "supession OK!"
	else	
		echo -e "ERREUR impossible de supprimer"
		exit 1
	fi
else
	echo " "
fi
}

read -p "Chemin du dossier a analyser: " chemin
liste=`ls $chemin | grep -v "201[7-8]"`

if [ -z "$liste" ]
then
	echo -e "\n Pas de supressions a faire ! \n"
	exit 1
else
	echo -e "\n A supprimer : "
	echo "-----------------------"
	echo -e "$liste \n"

	echo "Que voulez vous faire ?"
	echo -e "\n __________________MENU_________________"
	echo "---------------------------------------"
	echo " [1] Supprimer des fichiers	        "
	echo " [2] Supprimer des dossiers	        "
	echo -e "--------------------------------------- \n"

	read -p "Votre choix : " choix
	
	case $choix in
		1) for i in $liste
			do
				testy '-f' $chemin
			done
	;;
  		2) for i in $liste
			do
				testy '-d' $chemin			
			done
	;;		
  		*) echo "Erreur !"
	esac
fi

echo -e "\n __________Rapport_________"
echo "----------------------------------"
lstotal=`ls $chemin`
echo -e "\n Liste $chemin"
echo "----------------------"
echo "$lstotal"