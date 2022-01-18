#!/usr/bin/env sh

EXTRA_SITES=""

RUTA="/data"

SITES=$(ls -1 "$RUTA/sites/")
SITES=${SITES/www/}

SAVEIFS=$IFS
IFS=$'\n'

for HOST in $SITES; do
  EXTRA_SITES="$EXTRA_SITES${HOST// /-}.dockerbox.test -> http://nginx:80,"
done

IFS=$SAVEIFS

echo "EXTRA_SITES=$EXTRA_SITES" >>"$RUTA/.env"
