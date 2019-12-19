#!/bin/bash

# Description:
#	Permet l'installation de K8s sur Debian Buster (10)
#----------------------------------------------------------------#
# Usage: ./script_install_k8s.sh
#	Exécuter le script en root!
#
# Auteur:
#  	Daniel DOS SANTOS < daniel.massy91@gmail.com >
#----------------------------------------------------------------#

#variables
node_name=0
node_ip=$(hostname -I | awk '{print $1}')
remote_node_name=0
remote_node_ip=0
morenode="y"
loguser=$(cat /etc/passwd | grep 1000 | awk -F: '{print $1}')
gat=$(ip route | grep "default via" | awk '{print $3}')
inet=$(ip a show scope link | grep ^[[:digit:]] |awk -F: '{print $2}' | xargs)

#config réseau
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "
source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
allow-hotplug $inet
iface $inet inet static
	address $node_ip/24
	gateway $gat
" > /etc/network/interfaces

read -p "Nom DNS de la machine hôte : " node_name
#config dns
sed -i -e "/127.0.1.1/ s/debian/$node_name/g" /etc/hosts

#config hostname
#hostnamectl set-hostname $host1
hostname $node_name
echo $node_name > /etc/hostname
hostname

while [ $morenode != "n" ]
do
        read -p "Ajouter d'autres nodes? [y]/[n] : " morenode
        if [[ $morenode == "y" || $morenode == "Y" ]]
        then
                read -p "Nom DNS de la machine distante : " remote_node_name
                read -p "IP de la machine distante : " remote_node_ip
                #config dns
                echo "$remote_node_ip    $remote_node_name" >> /etc/hosts
        else
                echo "Pas d'autres nodes!"
        fi
done

echo "$node_name"
echo "$node_ip"
cat /etc/hosts

#déclaration d'un tableau
declare -a tabou

#config firewall
apt install ufw -y
yes | ufw enable
ufw allow 22/tcp
ufw allow 10248:10255/tcp
ufw allow 30000:32767/tcp
ufw allow 6443/tcp
ufw allow 2379:2380/tcp
ufw reload
ufw status verbose

update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
update-alternatives --set ebtables /usr/sbin/ebtables-legacy

cat <<EOF > /etc/ufw/sysctl.conf
net/bridge/bridge-nf-call-ip6tables = 1
net/bridge/bridge-nf-call-iptables = 1
net/bridge/bridge-nf-call-arptables = 1
EOF

#install Docker
apt update && apt full-upgrade -y
apt remove docker docker-engine docker.io -y
apt install curl -y
curl -fsSL https://get.docker.com | sh;
#If you would like to use Docker as a non-root user
usermod -aG docker $loguser
groupadd -g 500000 dockremap
groupadd -g 501000 dockremap-user
useradd -u 500000 -g dockremap -s /bin/false dockremap
useradd -u 501000 -g dockremap-user -s /bin/false dockremap-user
echo "dockremap:500000:65536" >> /etc/subuid
echo "dockremap:500000:65536" >>/etc/subgid

cat <<EOF >/etc/docker/daemon.json
{
 "userns-remap" : "default"
}
{
 "exec-opts" : ["native.cgroupdriver=systemd"]
}
EOF

systemctl daemon-reload
systemctl enable docker
systemctl restart docker
tabou=("$(docker --version)")

#conf swap
swapoff -a
cp /etc/fstab /etc/fstab.old
sed -i -e "/swap/ s/^UUID/#UUID/g" /etc/fstab
mount -a

#install k8s
apt install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt update
apt install -y kubelet
apt install -y kubeadm
apt install -y kubectl
apt install -y kubernetes-cni
#hold permet de marquer un paquet comme retenu, 
#ce qui empêchera qu'il soit installé,mis à jour ou supprimé #automatiquement.
apt-mark hold kubelet kubeadm kubectl kubernetes-cni
tabou+=("$(kubelet --version)")

#Install bash-completion
apt install bash-completion
source /usr/share/bash-completion/bash_completion
source ~/.bashrc

#Enable kubectl autocompletion
echo 'source <(kubectl completion bash)' >>~/.bashrc
kubectl completion bash >/etc/bash_completion.d/kubectl

#stats
clear
echo -e "\n====================="
echo "Fin de l'installation"
echo "====================="

for i in "${tabou[@]}"
do
        echo "$i"
done
echo -e "\nNom DNS du node : $node_name"
echo -e "IP du node : $node_ip \n"
echo -e "\n Merci de redémarrer la machine!"
