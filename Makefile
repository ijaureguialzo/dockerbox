help:
	@echo Opciones:
	@echo -------------------
	@echo start / stop / restart / stop-all
	@echo workspace
	@echo update
	@echo redis-cli / redis-flush
	@echo stats
	@echo clean
	@echo -------------------

_start-command:
	@docker run -v $(CURDIR)/:/data alpine /bin/sh /data/utils/extra-sites-nginx-conf.sh
	@docker run -v $(CURDIR)/:/data alpine sed -i '/^EXTRA_SITES/d' /data/.env
	@docker run -v $(CURDIR)/:/data alpine /bin/sh /data/utils/extra-sites-env.sh >> .env
	@docker-compose up -d --remove-orphans

start: _start-command _urls

stop:
	@docker-compose stop

restart: stop start

stop-all:
	@docker stop `docker ps -aq`

workspace:
	@docker-compose exec php /bin/bash

_build:
	@docker-compose pull && docker-compose build --pull

update: _build start

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
	@echo [MailDev] https://maildev.dockerbox.test
	@docker run -v $(CURDIR)/:/data alpine /bin/sh /data/utils/extra-sites-urls.sh
	@echo -------------------
