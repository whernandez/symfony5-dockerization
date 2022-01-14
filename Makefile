#!/bin/bash

ENV=dev
OS = $(shell uname)
BACKEND = php80-symfony5
APP_NAME = symphony540_test
APP_VERSION = ^5.4.0

help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

network: ## Create Network
	docker network create docker_default || true

cp-compose: ## Copy docker-compose
	cp -n docker-compose.yml.dist docker-compose.yml || true

cp-env: ## Copy .env
	cp -n .env.dist .env || true

up: ## Up the containers
	docker-compose up -d

down: ## Down the containers
	docker-compose down

init: ## Init the containers
	$(MAKE) network
	$(MAKE) cp-compose
	$(MAKE) cp-env
	$(MAKE) up

start: ## start the containers
	docker-compose start

stop: ## Stop the containers
	docker-compose stop

ps: ## Show container list
	docker-compose -f docker-compose.yml ps

restart: ## Restart the containers
	$(MAKE) stop && $(MAKE) up

build: ## Rebuilds all the containers
	$(MAKE) network
	$(MAKE) cp-compose
	$(MAKE) cp-env
	docker-compose up -d --build
	
app-prepare: ## Runs backend commands
	$(MAKE) app-install
	$(MAKE) app-migrations

ssh-be: ## bash into the backend container
	docker exec -it ${BACKEND} bash

# App alias
app-create: ## Create symphony app with composer
	docker exec -it ${BACKEND} composer create-project symfony/skeleton ${APP_NAME} ${APP_VERSION}
	
app-install: ## Installs composer dependencies
	docker exec -it ${BACKEND} composer install --no-interaction

app-update: ## Update composer dependencies
	docker exec -it ${BACKEND} composer update --no-interaction

app-migrations: ## Installs composer dependencies
	docker exec -it ${BACKEND} bin/console doctrine:migration:migrate -n --allow-no-migration

app-logs: ## Tails the Symfony dev log
	docker exec -it ${BACKEND} tail -f var/log/${ENV}.log

app-cclear: ## Symfony Cache Clear
	docker exec -it ${BACKEND} bin/console cache:clear --env=${ENV}

app-about: ## Symfony App about log
	docker exec -it ${BACKEND} bin/console about

app-codestyle: ## Runs php-cs to fix code styling following Symfony rules
	docker exec -it ${BACKEND} php-cs-fixer fix src --rules=@Symfony

.PHONY: migrations