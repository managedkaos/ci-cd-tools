.PHONY: up stop volume

up: volume
	docker-compose up -d
	@echo "http://localhost:8085"

volume:
	docker volume create --name bamboo-data

stop:
	docker-compose stop
