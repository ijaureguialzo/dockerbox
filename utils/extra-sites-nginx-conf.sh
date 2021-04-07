#!/usr/bin/env sh

RUTA="/data"

SITES=$(ls -1 "$RUTA/sites/")
SITES=${SITES/www/}

find $RUTA/nginx \( ! -name 'default.conf' -a ! -name 'dockerbox.conf' \) -type f -exec rm -f {} +

if [ -n "$SITES" ]; then

  SAVEIFS=$IFS
  IFS=$'\n'

  for HOST in $SITES; do
    cp "$RUTA/utils/extra-nginx.conf" "$RUTA/nginx/${HOST// /-}.conf"
    sed -i "s/EXTRA_HOST/${HOST// /-}/g" "$RUTA/nginx/${HOST// /-}.conf"
    sed -i "s/EXTRA_PATH/$HOST/g" "$RUTA/nginx/${HOST// /-}.conf"

    if [ ! -f "$RUTA/sites/$HOST/public/index.php" ]; then
      sed -i "s|/public||g" "$RUTA/nginx/${HOST// /-}.conf"
    fi
  done

  IFS=$SAVEIFS
fi
