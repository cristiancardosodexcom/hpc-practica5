#!/usr/bin/env bash
# Autor Cristian Cardoso

FILES_2="/bin/*"
FILES_1="/usr/bin/*"

original1=/firmas/firmas-bin.sha
original2=/firmas/firmas-usr-bin.sha

for file in $FILES_1; do
        sha=$(md5sum $file)
        existe=$(grep $sha $original1 | head -n 1)
        echo $existe
        if [[ -z "$existe" ]]; then
                echo "SHA differente, posible intrusion en archivo $file"
                exit 1
        else
            	echo "SHA valida $file"
        fi
done
for file in $FILES_2; do
        sha=$(md5sum $file)
        existe=$(grep $sha $original2 | head -n 1)
        echo $existe
        if [[ -z "$existe" ]]; then
                echo "SHA differente, posible intrusion en archivo $file"
                exit 1
        else
            	echo "SHA valida $file"
        fi
done
