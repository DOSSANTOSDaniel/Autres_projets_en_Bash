#!/bin/bash

# TITRE: Partage Vbox
#================================================================#
# DESCRIPTION:
#  Crée un lien symbolique du dossier partagé sur le répertoire personnel.
#----------------------------------------------------------------#
# AUTEURS:
#  Daniel DOS SANTOS < danielitto91@gmail.com >
#----------------------------------------------------------------#
# DATE DE CRÉATION: 27/05/2018
#----------------------------------------------------------------#
# VERSIONS: 1.0.0
#----------------------------------------------------------------#
# USAGE: ./script_partage.sh
#----------------------------------------------------------------#
# NOTES:
#  Outils utilisés VirtualBox 5.2, Debian 8.10, machine Phisique Debian 9.4
#----------------------------------------------------------------#
# BASH VERSION: GNU bash 4.4.12
#================================================================#

echo "
Création du lien de partage
----------------------------
"
sleep 2
read -p "Nom du partage configuré sur virtualbox ==> " partage
ln  -s  /media/sf_$partage/  /home/$(logname)/Partage_0
echo -e "\n Votre dossier de partage est: /home/$(logname)/Partage_0"
echo -e "\n Fin du script"
