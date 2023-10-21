#!/usr/bin/env bash
# Autor Cristian Cardoso

# Ejemplo :
# ./respaldos.sh /backups

# Resultado:
# /backups
#  /usuario1
#   /home
#  /usuario2
#   /home


# Primer parametro es el dictorio
# donde se guardara el respaldo de cada usuario
DIRECTORIO=$1

# Directorio temporal
TEMP="$DIRECTORIO/temp"

if [ -z $DIRECTORIO ]; then
	echo "Introduce el primer parametro"
	echo "El directorio output del respaldo"
	exit 1
fi

# Revisa directorio existe
if [ ! -d $DIRECTORIO ]; then
	echo "Creando directorio $DIRECTORIO"
	mkdir $DIRECTORIO
fi

# Obtiene todos los HOME's de los usuarios
fecha=$(date '+%m-%d-%y')
cat /etc/passwd | awk -F ":" '{ print $1" "$6 }' | sort -u |
while IFS= read -r file; do
	user=$(echo $file | awk '{ print $1 }')
	home=$(echo $file | awk '{ print $2 }')
	out="$TEMP/$user"
	echo "Generando respaldo usuario: $user"
	echo "Directorio home: $home"
	# omite el directorio root
	if [[ $home == "/" ]] || [[ $home == "/proc" ]]; then
		echo "Omitiendo directorio /"
		continue
	fi
	if [ ! -d $out ]; then
        	echo "Creando backup directorio $out"
        	mkdir -p $out
	fi
	cp -R $home $out
	echo "Respaldo de $user finalizado"
done;

# Creamos comprimido
tar -czvf "$DIRECTORIO/$fecha.tar" $TEMP

# Espacio del respaldo
total=$(du -sh "$DIRECTORIO/$fecha.tar")
echo "Total del respaldo: $total"

# Removemos temporal
rm -rf $TEMP

