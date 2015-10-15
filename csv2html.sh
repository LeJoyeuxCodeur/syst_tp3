#!/bin/bash
delim=";"

# Si au moins deux arguments sont présents (fichier d'entrée, fichier de sortie)
if [ $# -gt 1 ]
then
	# cas du -d
	if [ $# -eq 4 ]
	then
		if [ "$1" = "-d" ] && echo $2 | grep -qvE '[1-9]' && [ ${#2} -eq 1 ]
		then
			delim=$2
		else
			echo "Erreur, delimiteur non valide !"
		fi
		shift 2 # décale les args de 2 et supprime donc -d delim
	fi

	echo ' <!DOCTYPE html><html> <head> <meta charset="utf-8" /><title>Bieres</title></head><body><table border="1">' > $2
	sed -e "s/^/<tr><td>/g" -e "s/$delim/<\/td><td>/g" -e "s/$/<\/tr>/g" $1 >> $2
	echo '</table></body></html>' >> $2
else
	echo "Erreur, arguments manquants"
fi