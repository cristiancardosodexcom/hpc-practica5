#!/usr/bin/env bash
# Autor Cristian Cardoso

FILES_2="/bin/*"
FILES_1="/usr/bin/*"

mkdir /firmas
original1=/firmas/firmas-bin.sha
original2=/firmas/firmas-usr-bin.sha

for file in $FILES_1; do
        sha=$(md5sum $file)
        echo "$sha $file" >> $original1
done
for file in $FILES_2; do
        sha=$(md5sum $file)
        echo "$sha $file" >> $original2
done

cat $original1
cat $original2
echo "Finalizado"
