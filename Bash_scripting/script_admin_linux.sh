#!/bin/bash

### variables de couleurs ###

rouge='\e[0;31m' 
vert='\e[0;32m' 
orange='\e[0;33m' 
bleu='\e[0;34m'  
neutre='\e[0;m'

### fonctions ###
function ban
{
clear
	cat << "ban"
	 ____            _     
	| __ )  __ _ ___| |__  
	|  _ \ / _` / __| '_ \ 
	| |_) | (_| \__ \ | | |
	|____/ \__,_|___/_| |_|
ban
echo ""
echo -e "${vert}------------ $1 ------------${neutre}"
echo ""
sleep 2
}

function next
{
	echo ""
	read -p "Valider pour continuer"
}

function test
{
if [ $# = 0 ]
then
    error "Aucun argument recu !"
    next
    continue
else
	if [ -e "$1" ]
	then
		if [ -f "$1" ]
		then
			echo ""
			echo " Ceci est un fichier !"
			echo ""
		elif [ -d "$1" ]
		then
			echo ""
			echo " Ceci est un dossier !"
			echo ""
		else
			echo ""
			echo " Type inconnu de fichier !"
			echo ""
		fi
	else
		error "Ce fichier n'existe pas !"
	fi
fi
}

function error
{
	echo ""
	echo -e "${rouge} ERREUR ${neutre}"
	echo -e "${orange}-----------------------${neutre}"
	echo -e "${rouge} $1 ${neutre}"
	echo -e "${rouge} $2 ${neutre}"
}
ban "Bienvenue"
while :
do
clear
echo '               Menu'	
echo '------------------------------------'
echo '[1] Affichage repertoire courant'
echo '[2] Liste des fichiers du repertoire'
echo '[3] Information sur un fichier'
echo '[4] Changement de repertoire'
echo '[5] n premieres lignes d''un fichier'
echo '[0] Fin'
echo ''
read -p " votre choix : " ch
if [ -z "$ch" ] || [[ "$ch" != [0-5] ]]
	then
		error "Argument non pris en charge !" "seules arguments autorisés de [0] à [5] !"
		next
		continue
fi
case $ch in
0) ban "Fin du script"
   exit 0
;;
1) pwd
   next
;;
2) ls
   next
;;
3) echo -n 'Nom du fichier:' ; read file
   test $file
   ls -l $file 2> /dev/null
   next
;;
4) echo -n 'Nouveau repertoire:' ; read rep ; cd $rep
   next
;;
5) echo -n 'Nom du fichier:'; read file
echo -n 'Nb de lignes a afficher:' ; read n
head -$n $file
   next
;;
*) error "choix non proposé !"
esac
done
