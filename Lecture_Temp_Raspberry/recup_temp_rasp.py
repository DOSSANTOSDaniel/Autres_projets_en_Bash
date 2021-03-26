#!/usr/bin/python

def lireFichier (emplacement) :
    # Ouverture du fichier contenant l'information de la température
    fichTemp = open(emplacement)
    # Lecture du fichier
    contenu = fichTemp.read()
    # Fermeture du fichier après qu'il ai été lu
    fichTemp.close()
    return contenu

def recupTemp (contenuFich) :
    # Supprimer la première ligne qui est inutile
    secondeLigne = contenuFich.split("\n")[1]
    temperatureData = secondeLigne.split(" ")[9]
    # Supprimer le "t="
    temperature = float(temperatureData[2:])
    # Afficher un chiffre après la virgule
    temperature = temperature / 1000
    return temperature

contenuFich = lireFichier("/sys/bus/w1/devices/28-824532126461/w1_slave")
temperature = recupTemp (contenuFich)

print (temperature)
