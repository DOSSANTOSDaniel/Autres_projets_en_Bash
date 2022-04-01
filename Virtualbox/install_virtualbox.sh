#!/bin/bash

#Install VirtualBox
sudo apt-get update
sudo apt-get install virtualbox

#Install VirtualBox Extension Pack
sudo apt-get install virtualbox—ext–pack

#Add user to vboxusers group
sudo usermod -a -G vboxusers $USER
newgrp vboxusers


