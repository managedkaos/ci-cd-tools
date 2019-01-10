.PHONY: up stop volume

up: volume
	docker-compose up -d

volume:
	docker volume create --name bambooVolume

stop:
	docker-compose stop
