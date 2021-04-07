#!/usr/bin/env sh

RUTA="/data"

SITES=$(ls -1 "$RUTA/sites/")
SITES=${SITES/www/}

if [ -n "$SITES" ]; then

  echo -------------------

  SAVEIFS=$IFS
  IFS=$'\n'

  for HOST in $SITES; do
    echo "[$HOST] https://${HOST// /-}.dockerbox.test"
  done

  IFS=$SAVEIFS
fi
