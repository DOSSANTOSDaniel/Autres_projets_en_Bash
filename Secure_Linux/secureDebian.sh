
#!/bin/bash

#	Script permettant:
#	1- Securiser Debian.
#----------------------------------------------------------------#
#	Exécuter le script en root!
#
# daniel.massy91@gmail.com
#----------------------------------------------------------------#

apt update
apt full-upgrade

echo 'Modifier la ligne “PermitRootLogin yes” en “PermitRootLogin no”'

read -p "valider pour continuer"

nano /etc/ssh/sshd_config

systemctl restart ssh

# installation et configuration de fail2ban

apt-get install fail2ban

echo ' texte a modifier à la section ssh :

[ssh]

enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 6'

read -p "valider pour continuer"

nano /etc/fail2ban/jail.conf
