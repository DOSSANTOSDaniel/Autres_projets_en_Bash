#!/bin/bash

# Variables
REMOTE_IP='192.168.1.112'
REMOTE_USER='root'
SHARE_DOC='/home/Partage'
PA2SW='chayan'
COPY_FILE=''
DEST_DIR=''

while :
do
  # Bannière
  BAN1=`zenity --text-info \
  --title="Script DLNA Copy" \
  --width=500 \
  --height=300 \
  --html --url="https://upload.wikimedia.org/wikipedia/commons/f/fe/Itsukushima_torii_angle.jpg"`

  BAN2=`zenity --question \
  --width=500 \
  --height=300 \
  --title "DLNA Copy" \
  --text "Démarrage du script ou quitter ?" \
  --ok-label 'Démarrage' \
  --cancel-label 'Quitter'`
 
  if [ $? == 0 ]
  then
	# Menu de transfert
        COPY_FILE=`zenity --file-selection \
        --width=500 \
        --height=300 \
        --title="Sélectionnez un fichier ou un dossier"`

        # Menu choix de destination
        DEST_DIR=`zenity --list \
        --checklist \
        --width=500 \
        --height=300 \
        --window-icon= \
        --text="Dans quel dossier placer les données ?" \
        --column='Choix' --column='Type de média' \
        FALSE AUDIO FALSE PHOTO FALSE VIDEO`
        
        ### Transfert
        sudo rsync -AavxtrS --progress --partial "${COPY_FILE}" ${REMOTE_USER}@${REMOTE_IP}:${SHARE_DOC}/${DEST_DIR}

        ### Configuration des droits

        sudo sshpass -p ${PA2SW} ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_IP} "su -l root -c 'chown -R minidlna:minidlna ${SHARE_DOC}'"
        sleep 3
        sudo sshpass -p ${PA2SW} ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_IP} "su -l root -c 'chmod -R 777 ${SHARE_DOC}'"
        sleep 3

        sudo sshpass -p ${PA2SW} ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_IP} "su -l root -c 'systemctl restart minidlna'"
  else
	exit 1
  fi
done
