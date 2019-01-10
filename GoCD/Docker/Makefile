.PHONY: up stop volume

up: volume
	docker pull gocd/gocd-server:v18.12.0
	docker-compose up -d
	echo "http://localhost:8153"

volume:
	docker volume create --name gocd-data
	docker volume create --name gocd-home

stop:
	docker-compose stop
