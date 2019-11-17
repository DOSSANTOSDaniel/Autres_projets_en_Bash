#!/bin/bash
echo -e "\n vitesse d'écriture"
echo "--------------------"
sync; dd if=/dev/zero of=/tmp/smart bs=1M count=1024; sync

echo -e "\n vitesse de lécture"
echo "--------------------"
dd if=/tmp/smart of=/dev/null bs=1M count=1024

rm -rf /tmp/smart
