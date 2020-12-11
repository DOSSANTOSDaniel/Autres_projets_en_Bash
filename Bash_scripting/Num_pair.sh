#!/bin/bash
TABLEAU=()
read -p "Chemin complet du fichier : " FICHIER

for i in $(cat $FICHIER)
do
    if [ $i != 0 ]
    then
        CALCUL=$(($i % 2))
        if [ $CALCUL == 0 ]
        then
		    TABLEAU+=( $i )
        fi
    fi
done

echo "${TABLEAU[@]}"
