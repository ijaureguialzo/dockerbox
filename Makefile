#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
	unexport EXTRA_SITES
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo --------------------------------------------------------
	@echo start / start-expose-mariadb / stop / restart / stop-all
	@echo reload
	@echo workspace
	@echo build
	@echo redis-cli / redis-flush
	@echo mutagen-status
	@echo stats
	@echo clean
	@echo --------------------------------------------------------

_header:
	@echo ---------------
	@echo dockerbox $(shell git describe --tags)
	@echo ---------------

_extra_sites:
	@docker run --rm -v "$(CURDIR)/:/data" alpine:${ALPINE_VERSION} /bin/sh -c "/bin/sh /data/utils/extra-sites-nginx-conf.sh && sed -i '/^EXTRA_SITES/d' /data/.env && /bin/sh /data/utils/extra-sites-env.sh"

_start-command:
	@docker compose up -d --remove-orphans

_start-command-mariadb:
	@docker compose -f docker-compose.yml -f docker-compose.mariadb.yml up -d --remove-orphans

_mutagen-start:
	@mutagen daemon start
	@mutagen sync create --name=dockerbox-php sites docker://dockerbox-php-1/var/www/html --sync-mode=two-way-resolved --ignore-vcs -i .idea -i *.log -i supervisord.log --default-owner-beta=www-data --default-group-beta=www-data --default-file-mode=644 --default-directory-mode=755
	@mutagen sync create --name=dockerbox-nginx sites docker://dockerbox-nginx-1/var/www/html --sync-mode=one-way-replica --ignore-vcs --default-file-mode-beta=644 --default-directory-mode-beta=755

_mutagen-stop:
	@mutagen daemon start
	@mutagen sync terminate -a

start: _mutagen-stop _extra_sites _start-command _mutagen-start _urls

start-expose-mariadb: _mutagen-stop _extra_sites _start-command-mariadb _mutagen-start _urls

_stop_web_containers:
	@docker compose stop https-portal nginx

reload: _mutagen-stop _extra_sites _stop_web_containers _start-command _mutagen-start _urls

stop:
	-@$(MAKE) _mutagen-stop
	@docker compose stop

restart: stop start

stop-all:
	-@$(MAKE) _mutagen-stop
	@docker stop $(shell docker ps -aq)

workspace:
	@docker compose exec php /bin/bash

build:
	@docker compose pull && docker compose build --pull

redis-cli:
	@docker compose exec redis redis-cli

redis-flush:
	@docker compose exec redis redis-cli flushall

mutagen-status:
	@mutagen sync list

stats:
	@docker stats

clean:
	-@$(MAKE) _mutagen-stop
	@docker compose down -v --remove-orphans

_urls: _header
	${info }
	@echo Sitios disponibles:
	@echo --------------------------------------------------------
	@echo [Sitio web] https://dockerbox.test
	@echo [phpMyAdmin] https://phpmyadmin.dockerbox.test
	@echo [phpRedisAdmin] https://phpredisadmin.dockerbox.test
	@echo [Mailpit] https://mailpit.dockerbox.test
	@echo [Vite] https://vite.dockerbox.test
	@docker run --rm -v "$(CURDIR)/:/data" alpine:${ALPINE_VERSION} /bin/sh /data/utils/extra-sites-urls.sh
	@echo --------------------------------------------------------
