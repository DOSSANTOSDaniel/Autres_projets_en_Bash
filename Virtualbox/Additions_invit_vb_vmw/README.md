# additions_invit-_vb_vmw
Installation des additions invité sur une machine virtuelle sous Debian en utilisant soit VirtualBox soit VMware

guest vbox debian 8
----------------------

général >> avancé
------------------
Presse-papier partagé: Bidirectionnel
Glisser-déposer: Bidirectionnel

Système >> Carte mère
----------------------
Décocher: Disquette

Stockage
---------
Placer l'image ISO dans le lecteurs cd.




Drag and drop
---------------
Même avec une configuration en Bidirectionnel cela fonctionne pas.
Cela fonctionne par moment si on copie des dossiers de la machine physique vers la machine virtuelle.
Ces dossiers son copié dans la machine virtuelle dans le répertoire: /home/$user/Documents/"VirtualBox Dropped Files".



additions_guests.sh
--------------------
Anciens script qui rasemblait tous les procéssus.


guests_VBox_Debian_8.sh
-----------------------
Install des aditions pour Debian 8 sur VirtualBox.


guests_VBox_Debian_9.sh
-----------------------
Install des aditions pour Debian 9 sur VirtualBox.


guests_VMw_Debian_8.sh
----------------------
Install des aditions pour Debian 8 sur VMware.


guests_VMw_Debian_9.sh
----------------------
Install des aditions pour Debian 9 sur VMware.


partage_vbox.sh
---------------
Création d'un lien du dossier partagé entre la machine phisique et la machine virtuelle.

