# dockerbox

Entorno de desarrollo para programación web con Docker.

## Instalación

1. Instalar [Docker](https://www.docker.com/get-started).
2. Clonar este repositorio.
3. Copiar el fichero `env-example` a `.env` y cambiar las contraseñas por defecto.
4. Arrancar los servicios:
   - Desarrollo: `docker-compose up -d`
   - Producción: `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build`

## Servicios

### Servidor web

- Apache, publicando la carpeta `www` en [localhost](http://localhost/).
- Utiliza la imagen de [WebDevOps](https://hub.docker.com/r/webdevops/php-apache-dev).

### Base de datos

- Imagen oficial de [MariaDB](https://hub.docker.com/_/mariadb).
- Crea una base de datos vacía, por defecto `dockerbox`, accesible con el usuario definido en el fichero `.env`.

## Utilidades

- Imagen oficial de [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin) accesible en [localhost:8080](http://localhost:8080/).
- Acceso mediante shell: `docker-compose exec web /bin/bash`
- Si se cambia la versión de PHP del servidor web, actualizar la imagen con: `docker-compose build web`
