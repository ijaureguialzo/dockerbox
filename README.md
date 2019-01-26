# dockerbox

Entorno de desarrollo para programación web con Docker.

## Instalación

1. Instalar [Docker](https://www.docker.com/get-started).
2. Clonar este repositorio.
3. Arrancar los servicios con `docker-compose up -d`

## Servicios

### Servidor web

- Apache, publicando la carpeta `www` en [localhost](http://localhost/).
- Utiliza la imagen con PHP 7.3 de [WebDevOps](https://hub.docker.com/r/webdevops/php-apache-dev).

### Base de datos

- Imagen oficial de MariaDB versión 10.3.
- Crea una base de datos vacía, `dockerbox`, accesible con el usuario `dockerbox/12345Abcde`.

## Utilidades

- Imagen oficial de [phpMyAdmin](http://localhost:8080/) accesible con el usuario `root/12345Abcde`.
- Acceso mediante shell: `docker-compose exec web /bin/bash`
