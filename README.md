# dockerbox

Entorno de desarrollo para programación web con PHP en Docker.

## Instalación

1. Instalar Docker para [Windows y macOS](https://www.docker.com/products/docker-desktop)
   o [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/).

   > En Windows y macOS, para evitar errores de credenciales al descargar contenedores, hay
   > que registrarse en [Docker Hub](https://hub.docker.com) e iniciar sesión con esa cuenta
   > en Docker Desktop.

2. Editar como root el fichero `/etc/hosts` (en macOS y Linux) o
   en [Windows](https://www.adslzone.net/esenciales/windows-10/editar-archivo-host/) y añadir:

   ```text
   127.0.0.1	dockerbox.test
   127.0.0.1	phpmyadmin.dockerbox.test
   127.0.0.1	maildev.dockerbox.test
   ```

3. Clonar este repositorio:

   ```shell
   git clone https://github.com/ijaureguialzo/dockerbox.git
   ```

4. En un terminal, situarse en la carpeta `dockerbox` (o si se ha renombrado, la que contenga este archivo `README.md`):

   ```shell
   cd dockerbox
   ```

5. Copiar el fichero `env-example` a `.env`:

   En macOS y Linux:

   ```shell
   cp env-example .env
   ```

   En Windows:

   ```shell
   copy env-example .env
   ```

   > :warning: Es recomendable cambiar las contraseñas por defecto.

6. Arrancar los servicios:

   ```shell
   make start
   ```

   > En Windows, para usar el comando `make`, hay que [instalar Chocolatey](https://chocolatey.org/install) y después instalarlo mediante `choco install make`.

## Servicios

- [Sitio web](https://dockerbox.test)
- [phpMyAdmin](https://phpmyadmin.dockerbox.test)
- [MailDev](https://maildev.dockerbox.test)

## Utilidades

- Acceso mediante shell al contenedor de php:

  ```shell
  make workspace
  ```

- Actualizar los contenedores:

  ```shell
  make update
  ```

## (Opcional) Añadir un nuevo sitio web

1. Crear una nueva carpeta `sites/nuevo_sitio` con el contenido del nuevo sitio web.

2. Editar como root el fichero `/etc/hosts` (en macOS y Linux) o
   en [Windows](https://www.adslzone.net/esenciales/windows-10/editar-archivo-host/) y añadir una nueva línea:

   ```text
   127.0.0.1    nuevo_sitio.dockerbox.test
   ```

3. Recargar los contenedores web:

    ```bash
    make reload
    ```

4. Acceder al [nuevo sitio](https://nuevo_sitio.dockerbox.test).

## (Opcional) Depurar con Xdebug y PhpStorm

1. Modificar el fichero `.env` añadiendo la dirección IP del ordenador en la variable `XDEBUG_REMOTE_HOST`.
2. Habilitar la escucha de conexiones de depuración en PhpStorm haciendo click en el
   icono: <img src="docs/debug_listener.png" width="26" alt="Icono de escucha de conexión de Xdebug" />
3. Fijar un _breakpoint_ y cargar la página en el navegador.

## (Opcional) Habilitar el puerto de MariaDB en localhost

1. Editar el fichero `docker-compose.yml` y añadir:

   ```yaml
     mariadb:
       ports:
         - 3306:3306
   ```

2. Recrear el contenedor `mariadb` para que se aplique el cambio:

   ```shell
   make start
   ```

## Estructura de dockerbox

![Diagrama de contenedores de dockerbox](docs/servicios.png)
