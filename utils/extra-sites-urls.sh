#!/usr/bin/env bash

SITES=$(ls -1 sites/)
SITES=${SITES/www/}

if [ -n "$SITES" ]; then

  echo -------------------

  SAVEIFS=$IFS
  IFS=$'\n'

  for LINEA in $SITES; do
    NOMBRE="$(cut -d '|' -f1 <<<"$LINEA")"
    HOST="$(cut -d '|' -f2 <<<"$LINEA")"

    echo "[$NOMBRE] https://${HOST// /-}.dockerbox.test"
  done

  IFS=$SAVEIFS
fi
