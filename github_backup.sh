#!/usr/bin/env bash

user='DOSSANTOSDaniel'
api_base='https://api.github.com'
v3_accept='Accept: application/vnd.github.symmetra-preview+json'
repos="$(curl -s -f -H ${v3_accept} ${api_base}/users/${user}/repos | jq -r .[].name)"
target='/home/daniel/Nextcloud/BACK_UP/Backup_github_02_2021'

for rep in ${repos}
do
  git clone https://github.com/${user}/${rep}.git ${target}/${rep} && echo -e "\n [OK] Clone de ${rep} OK! dans ${target}/${rep} \n"
done

# Private
git clone https://github.com/DOSSANTOSDaniel/valkeywin.git ${target}/valkeywin && echo -e "\n [OK] Clone de valkeywin OK! dans ${target}/valkeywin \n"

# Wiki
git clone https://github.com/DOSSANTOSDaniel/MAAS_JUJU_K8S_Openstack.wiki.git ${target}/WIKI/MAAS_JUJU_K8S_Openstack && echo -e "\n [OK] Clone du wiki MAAS_JUJU_K8S_Openstack OK! dans ${target}/WIKI \n"
