#!/usr/bin/env bash

EXTRA_SITES=""

SITES=$(ls -1 sites/)
SITES=${SITES/www/}

SAVEIFS=$IFS
IFS=$'\n'

for LINEA in $SITES; do
  HOST="$(cut -d '|' -f2 <<<"$LINEA")"

  EXTRA_SITES="$EXTRA_SITES${HOST// /-}.dockerbox.test -> http://nginx:80,"
done

IFS=$SAVEIFS

export EXTRA_SITES
