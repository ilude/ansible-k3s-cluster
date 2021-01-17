# https://unix.stackexchange.com/a/348432
include .env
export

DEFAULT_SERVICE := $(shell docker-compose config --services 2>/dev/null | head -n 1)

PUID := $(shell id -u)
PGID := $(shell id -g)
export PUID
export PGID

bash: build 
	docker-compose run --rm ${DEFAULT_SERVICE} 
	docker-compose down --remove-orphans

attach: 
	docker-compose exec ${DEFAULT_SERVICE} /bin/zsh

logs:
	docker-compose logs -f

build: 
	docker-compose build --progress=plain

echo:
	env|sort
