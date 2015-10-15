echo "<html> <body> <table border="1">" >> $2

cat $1 | while IFS=';;' read ligne
do
	echo "<tr>" >> $2

	for i in `seq 1 12`
	do
		echo "<td>" >> $2
		echo $ligne | cut -f $i -d "$delim" >> $2
		echo "</td>" >> $2
	done

	echo "</tr>" >> $2 
done
echo "</table> </body> </html>" >> $2