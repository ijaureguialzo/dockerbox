help:
	@echo Opciones:
	@echo start / stop / restart / stop-all
	@echo workspace
	@echo build / build-nocache
	@echo stats
	@echo clean

_start-command:
	@docker-compose up -d --remove-orphans

start: _start-command _urls

stop:
	@docker-compose stop

restart: stop start

stop-all:
	@docker stop `docker ps -aq`

workspace:
	@docker-compose exec php /bin/bash

build:
	@docker-compose pull && docker-compose build --pull --parallel

build-nocache:
	@docker-compose pull && docker-compose build --pull --parallel --no-cache

stats:
	@docker stats

clean:
	@docker-compose down -v --remove-orphans

_urls:
	@echo ""
	@echo "--------------------"
	@echo "\033[92m[Sitio web]\033[0m https://dockerbox.test"
	@echo "\033[92m[phpMyAdmin]\033[0m https://phpmyadmin.dockerbox.test"
	@echo "\033[92m[MailDev]\033[0m https://maildev.dockerbox.test"
	@echo "--------------------"
