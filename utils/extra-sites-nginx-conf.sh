#!/usr/bin/env bash

SITES=$(ls -1 sites/)
SITES=${SITES/www/}

if [ -n "$SITES" ]; then

  find ./nginx/ \( ! -name 'default.conf' -a ! -name 'dockerbox.conf' \) -type f -exec rm -f {} +

  SAVEIFS=$IFS
  IFS=$'\n'

  for LINEA in $SITES; do
    HOST="$(cut -d '|' -f2 <<<"$LINEA")"

    sed "s/EXTRA/${HOST// /-}/g" utils/extra-nginx.conf >"nginx/${HOST// /-}.conf"
  done

  IFS=$SAVEIFS
fi
