#!/bin/bash
# script_tput.sh 
#### Initialisation des variables #### 
#+ Mode normal 
ResetColor="$(tput sgr0)" 
# "Surligné" (bold) 
bold=$(tput smso) 
# "Non-Surligné" (offbold) 
offbold=$(tput rmso) 
# Couleurs (gras) #+ Rouge 
Red="$(tput bold ; tput setaf 1)" 
#+ Vert Green="$(tput bold ; tput setaf 2)" 
#+ Jaune 
Yellow="$(tput bold ; tput setaf 3)" 
#+ Bleue 
Blue="$(tput bold ; tput setaf 4)" 
#+ Cyan 
BlueCyan="$(tput bold ; tput setaf 6)"
#### Fin initialisation variables #### 
# Effacement du terminal
clear 
# Adressage du curseur ligne 0 colonne 2 
tput cup 0 2 
echo "Entrez les informations demandées dans le champ ayant le curseur." 
# Adressage du curseur ligne 1 colonne 2 
tput cup 1 2 
echo "Appuyez sur Entrée pour passer au champ suivant." 
# Adressage du curseur ligne 3 colonne 20 
tput cup 3 30 
echo "${bold}Questions/Réponses${offbold}" 
# Pré-affichage des champs 
tput cup 5 5 
echo -e "Nom : \c" tput cup 7 5 echo -e "Prénom : \c" 
tput cup 9 5 
echo -e "Age : \c" 
# Facultatif # Pré-affichage des données tput cup 12 2 
echo -e "Votre nom est : " tput cup 13 2 
echo -e "Votre prénom est : " tput cup 14 2 
echo -e "Vous avez ans. " 
#### Interaction du script #### # Adressage du curseur ligne 5 colonne 5 tput cup 5 5 
echo -e "Nom : \c" read nom 
# Adressage du curseur ligne 7 colonne 5 
tput cup 7 5 
echo -e "Prénom : \c" read prenom # Adressage du curseur ligne 9 colonne 5 tput cup 9 5
echo -e "Age : \c" read age #### Affichage des réponses #### # Adressage du curseur ligne 12 colonne 2 
tput cup 12 2 
echo -e "${Green}Votre nom est : ${ResetColor}"${Red}$nom${ResetColor} 
# Adressage du curseur ligne 13 colonne 2 
tput cup 13 2 
echo -e "${Green}Votre prénom est : ${ResetColor}"${BlueCyan}$prenom${ResetColor} 
# Adressage du curseur ligne 14 colonne 2 
tput cup 14 2 
echo -e "${Green}Vous avez ${Yellow}$age ${Green}ans. ${ResetColor}" # Adressage du curseur ligne 20 colonne 0 tput cup 20 0

#https://www.it-connect.fr/linux-gestion-dadressage-du-curseur-avec-tput/
