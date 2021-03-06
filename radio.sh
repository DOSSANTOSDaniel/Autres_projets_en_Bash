#/bin/bash
#************************************************#
# Nom:     radio.sh                              #
# Auteur:  daniel <daniel.massy91@gmail.com>     #
# Date:    04/03/2021                            #
# Version: 1.0                                   #
#                                                #
# Rôle:    Permet d'écouter certaines radios     #
#          directement sur le terminal.          #
#                                                #
# Usage:   ./radio.sh                            #
#                                                #
# Limites: Les URL des radios doivent être       #
#          insérées à la main dans le script.    #
#************************************************#

app='mplayer'

if [[ ! $(dpkg -s ${app} 2> /dev/null) && $(command -v ${app} 2> /dev/null) ]]
then
  echo -e "\n Installation de ${app} en cours \n"
  sudo apt-get update -q
  sudo apt-get install -qy ${app}

  if [[ "${?}" == "0" ]]
  then
    echo -e "\n INFO : Installation de ${app} réussie ! \n"
  else
    echo -e "\n INFO : Installation de ${app} impossible ! \n"
    exit 1
  fi
fi

declare -A url
url=(
  ["RFM"]="http://stream.europe1.fr/europe1.mp3"
  ["FR_CULTURE"]="http://icecast.radiofrance.fr/franceculture-midfi.mp3"
)

count_url="${#url[@]}"
regex="[1-${count_url}]"
PS3="Votre choix : "

while :
do
  echo -e "\n -- Menu Radio -- "
  select ITEM in "${!url[@]}" 'Aide' 'Quitter'
  do
    case $ITEM in
  Aide)
      echo -e "\n ---- Aide ----"
      echo ' ./radio.sh'
      echo
      echo ' Pour quitter une radio tapez sur <entrée>'
      echo ' Pour quitter le script sélectionner <Quitter>'
      echo ' --------------'
      break
    ;;
  Quitter)
      echo -e "\n Fin du script ! \n"
      exit 0
    ;;
  *)	  
    if [[ ${REPLY} =~ ${regex} ]]
    then
      url_radio="${url[$ITEM]}"
      mplayer "$url_radio"
      break
    else
      echo -e "\n ERREUR de saisie"
      echo -e " ${REPLY} correspond pas avec les valeurs attendues !\n"
      break
    fi
    ;;
    esac
  done
done
