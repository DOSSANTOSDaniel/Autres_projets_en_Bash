#!/bin/bash

readonly ext_1="${1}"
readonly dir_scan='/home/daniel/Nextcloud'
readonly dir_copy='/home/daniel/BOOKS'

declare -i count_zero="0"
readonly total_book="$(find ${dir_scan} -iname *.${ext_1} | wc -l)"

find ${dir_scan} -iname *.${ext_1} -o -iname *.${ext_1} | \
while read line
do
  clear
  echo -e "\n Super Copy"
  echo -e "--------------- \n"
  ((count_zero++))
  echo "Fichiers : ${count_zero} / ${total_book}"
  rsync -vxt --progress --partial "${line}" "${dir_copy}"
done
