#!/bin/bash

#Pour afficher le résultat de la commande et en même temps mettre le résultat dans un fichier
commande | tee output.txt
#pareil que:
commande > toto.txt

commande | tee -a output.txt
#pareil que:
commande >> toto.txt
