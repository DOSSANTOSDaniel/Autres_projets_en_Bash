# Mémo des commandes 

La commande yes pour répondre automatiquement ex:
-------------------------------------------------
yes | apt-get install htop

Diagnostique réseau
--------------------
mtr 8.8.8.8

Afficher la météo
-------------------
curl wttr.in

Affiche les dossiers les plus lourd dans un point de l'arborescence
--------------------------------------------------------------------
ncdu

Affiche IP
-----------
hostnamectl -I

Supprime disque
---------------
nwipe

Affiche infos HW
-----------------
inxi -Fx

Affiche le % des disques
-------------------------
pydf

Logo Linux sur le terminal
----------------------------
linuxlogo -L list

Alternative à SSH
--------------------
mosh

Vocal
-------
espeak -v fr "titi toto"

Installation des bureaux
-------------------------
Tasksel
https://wiki.debian-fr.xyz/Tasksel

Test port
-----------
telnet localhost 22

Permet de télécharger des objets comme avec wget
-----------------------------------------------------
curl -L -O url

-L   suivre une redirection

-O sauvegarde le fichier avec le nom source

Commande permettant de supprimer tous le images et containers
---------------------------------------------------------------
docker system prune

Garder la connexion en SSH
----------------------------
ssh -o "ServerAliveInterval 60" user@domain

Affiche l'ocupation des disques
--------------------------------
dfc
