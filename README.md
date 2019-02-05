# dockerbox

Entorno de desarrollo para programación web con Docker.

## Instalación

1. Instalar [Docker](https://www.docker.com/get-started).
2. Clonar este repositorio.
3. Copiar el fichero `env-example` a `.env` y `.env.prod`, cambiando las contraseñas por defecto.
4. Arrancar los servicios:
   - Desarrollo: `docker-compose up -d`
   - Producción: `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`

## Servicios

### Servidor web

- Apache, publicando la carpeta `www` en [localhost](http://localhost/).
- Utiliza la imagen con PHP 7.3 de [WebDevOps](https://hub.docker.com/r/webdevops/php-apache-dev).

### Base de datos

- Imagen oficial de MariaDB versión 10.3.
- Crea una base de datos vacía, `dockerbox`, accesible con el usuario definido en el fichero `.env` correspondiente.

## Utilidades

- Imagen oficial de [phpMyAdmin](http://localhost:8080/) accesible con el usuario definido en el fichero `.env` correspondiente.
- Acceso mediante shell: `docker-compose exec web /bin/bash`
