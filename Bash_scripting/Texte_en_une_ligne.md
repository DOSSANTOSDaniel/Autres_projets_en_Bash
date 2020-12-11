## Permet de formater un texte de manière à l'afficher que dans un seule ligne :

```bash
cat toto.txt | tr -s '\n' ' ' > Jovial.txt
```
## Exemple :

```bash
# Affichage du fichier avec cat
[daniel🐧iS3810](~)$ cat fichier.txt 

1
2
3
4
5

# Affichage en ligne, transforme les retours à la ligne en espaces
[daniel🐧iS3810](~)$ cat fichier.txt | tr -s '\n' ' '

1 2 3 4 5
```
