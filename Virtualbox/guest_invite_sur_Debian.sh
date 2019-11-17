#!/bin/bash
# Incertion du disque, copie du disque sur un fichier temporaire
apt-get install build-essential linux-headers-`uname -r` dkms
./VBoxLinuxAdditions.run
