LOGIN =		lodemetz
DOMAIN =	${LOGIN}.42.fr
DATA_PATH = /home/${LOGIN}/data
ENV =		LOGIN=${LOGIN} DATA_PATH=${DATA_PATH} DOMAIN=${DOMAIN}

all: up

up: setup
	 ${ENV} docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	${ENV} docker-compose -f ./srcs/docker-compose.yml down

start:
	${ENV} docker-compose -f ./srcs/docker-compose.yml start

stop:
	${ENV} docker-compose -f ./srcs/docker-compose.yml stop

re: stop down fclean up start

status:
	cd srcs && docker-compose ps && cd ..

logs:
	cd srcs && docker-compose logs && cd ..

setup:
	sudo mkdir -p /home/${LOGIN}/
	sudo mkdir -p ${DATA_PATH}
	sudo mkdir -p ${DATA_PATH}/mariadb-data
	sudo mkdir -p ${DATA_PATH}/wordpress-data

clean:
	sudo rm -rf ${DATA_PATH}

fclean: clean
	docker system prune -f -a --volumes
	docker volume rm srcs_mariadb-data srcs_wordpress-data

.PHONY: all up down start stop status logs prune clean fclean
