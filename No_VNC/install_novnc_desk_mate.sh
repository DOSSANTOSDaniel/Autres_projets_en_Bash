debuser="toto"
debpasswd="toto2019"
rootpasswd="$debpasswd"
lang="LANG=fr_FR.UTF-8"
apt update
apt install dialog
apt install apt-utils
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get install locales
export $lang
apt install vnc4server
apt install git
git clone https://github.com/novnc/noVNC.git
cd /home/$debuser/noVNC/utils
apt install tasksel -y
tasksel install lxde-desktop
yes $debpasswd | vncpasswd
vncserver
/root/noVNC/utils/launch.sh --vnc localhost:5901"

