help:
	@echo Opciones:
	@echo -------------------
	@echo start / start-expose-mariadb / stop / restart / stop-all
	@echo reload
	@echo workspace
	@echo build
	@echo redis-cli / redis-flush
	@echo stats
	@echo clean
	@echo -------------------

_extra_sites:
	@docker run --rm -v "$(CURDIR)/:/data" alpine /bin/sh -c "/bin/sh /data/utils/extra-sites-nginx-conf.sh && sed -i '/^EXTRA_SITES/d' /data/.env && /bin/sh /data/utils/extra-sites-env.sh"

_start-command:
	@docker-compose up -d --remove-orphans

_start-command-mariadb:
	@docker-compose -f docker-compose.yml -f docker-compose.mariadb.yml up -d --remove-orphans

start: _extra_sites _start-command _urls

start-expose-mariadb: _extra_sites _start-command-mariadb _urls

_stop_web_containers:
	@docker-compose stop https-portal nginx

reload: _stop_web_containers start

stop:
	@docker-compose stop

restart: stop start

stop-all:
	@docker stop `docker ps -aq`

workspace:
	@docker-compose exec php /bin/bash

build:
	@docker-compose pull && docker-compose build --pull

redis-cli:
	@docker-compose exec redis redis-cli

redis-flush:
	@docker-compose exec redis redis-cli flushall

stats:
	@docker stats

clean:
	@docker-compose down -v --remove-orphans

_urls:
	${info }
	@echo -------------------
	@echo [Sitio web] https://dockerbox.test
	@echo [phpMyAdmin] https://phpmyadmin.dockerbox.test
	@echo [phpRedisAdmin] https://phpredisadmin.dockerbox.test
	@echo [MailCatcher] https://mailcatcher.dockerbox.test
	@docker run --rm -v "$(CURDIR)/:/data" alpine /bin/sh /data/utils/extra-sites-urls.sh
	@echo -------------------
