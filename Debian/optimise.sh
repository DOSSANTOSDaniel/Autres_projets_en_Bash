#!/bin/bash

## Optimisation de Debian 9

### Ce script va permettre l'optimisation d'une installation de Debian 9:
# * En mode non graphique.
# * En mode graphique sur un desktop.
# * En mode graphique sur un laptop.

# *Source :* http://le-libriste.fr/2009/04/5-moyens-dameliorer-les-performances-de-votre-poste-linux/#1-forcer-l%e2%80%99utilisation-de-la-memoire-vive-au-depend-de-la-swap

# souce :
#http://le-libriste.fr/2009/04/5-moyens-dameliorer-les-performances-de-votre-poste-linux/#1-forcer-l%e2%80%99utilisation-de-la-memoire-vive-au-depend-de-la-swap

# % memoire à la suite de laquelle on active swap
echo "vm.swappiness = 10" >> /etc/sysctl.conf

# pcmcia
update-rc.d -f pcmciautils remove
update-rc.d -f pcmcia remove

#bluetooth
update-rc.d -f bluetooth remove
update-rc.d -f bluez-utils remove

# désactivons la gestion des touches bleus
update-rc.d -f hotkey-setup remove

# batterie
update-rc.d -f laptop-mode remove

# raid
update-rc.d -f mdadm remove
update-rc.d -f mdadm-raid remove

#LVM
update-rc.d -f lvm remove

#Enterprise Volumn Management System: EVM
update-rc.d -f evms remove

#Modem
update-rc.d -f dns-clean remove

# reduire le  nombre de consoles au démarrage
sed -i -e "s/ACTIVE_CONSOLES="/dev/tty[1-6]"/ACTIVE_CONSOLES="/dev/tty[1-2]"/g" /etc/default/console-setup

# modifier les programes inutils au démarrage 
apt-get install rcconf
rcconf

# A integrer au script : 5. Démarrer GRUB en mode « profile »

#améliore les temps de chargement
apt-get install preload
preload

#optimisation SSD
#source :
#https://debian-facile.org/viewtopic.php?id=15371
cp /usr/share/doc/util-linux/examples/fstrim.{service,timer} /etc/systemd/system
systemctl enable fstrim.timer
systemctl start fstrim.timer

#a voir :
#http://www.monitis.com/blog/20-linux-server-performance-tips-part-2/
