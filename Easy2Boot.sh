Installation de Easy2Boot
---------------------------
obligation:
Linux mint 19.1.0

sudo su

apt update

apt full-upgrade

télécharger de easy2boot
----------------------------

su <nom de l'utilisateur courant>

firefox https://www.fosshub.com/Easy2Boot.html?dwl=Easy2Boot_v1.B3.zip

Enregistrement du zip dans Téléchargement

exit

cd /opt/

mkdir E2B

cd E2B

mv /home/<nom de l'utilisateur courant>/Téléchargements/Easy2Boot_v*.zip /opt/E2B/

unzip Easy2Boot_v1.B3.zip

cd _ISO/docs/linux_utils/

chmod 777 *

lsblk

bash fmt_ntfs.sh

choisir la bonne clé
yes
------------------------------------

Is target device (/dev/sdc1) correct (y/n) : y


Partition = 1
Formatting: /dev/sdc1

Proceed with formatting (y/n): y
------------------------------------
attendre 5min 4go
attendre 30min 32 go

-----------------------------------------------

dpkg --add-architecture i386
apt update
apt install libc6:i386 libncurses5:i386 libstdc++6:i386

-----------------------------------------------

lsblk

./udefrag -om /dev/sdb1

enlever et remettre la clé usb


FIN de l'install

procédure pour ajouter des isos
1 copier coller l'iso dans son dossier
2 deframenter


cd /opt/E2B/_ISO/docs/linux_utils/

lsblk

umount /dev/sdb1

./udefrag -om /dev/sdb1
