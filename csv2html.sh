#!/bin/bash

# Si au moins deux arguments sont présents (fichier d'entrée, fichier de sortie)
if [ $# -gt 1 ]
then
	echo ' <!DOCTYPE html><html> <head> <meta charset="utf-8" /><title>Bieres</title></head><body><table border="1">' > ${!#}
	
	# traitement sans arguments
	if [ $# -eq 2 ]
	then
		sed -e "s/^/<tr><td>/g" -e "s/;/<\/td><td>/g" -e "s/$/<\/tr>/g" $1 >> $2
		echo Traitement sans arguments effectué
	# traitement avec arguments
	elif [ $# -eq 4 ]
	then
		# cas du -d
		if [ "$1" = "-d" ] && echo $2 | grep -qvE '[0-9]' && [ ${#2} -eq 1 ]
		then
			sed -e "s/^/<tr><td>/g" -e "s/$2/<\/td><td>/g" -e "s/$/<\/tr>/g" $3 >> $4
			echo Traiment avec le délimiteur "$2" effectué
		
		# cas du -s
		elif [ "$1" = "-s" ] && echo $2 | grep -qE '[0-9][0-9]' && [ ${#2} -eq 2 ]
		then
			sort -t";" -k"$2","$2" $3 | sed -e "s/^/<tr><td>/g" -e "s/;/<\/td><td>/g" -e "s/$/<\/tr>/g" >> $4
			echo Traiment avec le tri sur la colonne "$2" effectué

		# cas du -S
		elif [ "$1" = "-S" ] && echo $2 | grep -qE '[a-z][A-Z]']
		then
			# TODO
		else
			echo "Erreur, delimiteur non valide !"
		fi		
	else
		echo "Erreur, mauvais nombre d'arguments"
	fi
	echo '</table></body></html>' >> ${!#}
else
	echo "Erreur, arguments manquants"
fi