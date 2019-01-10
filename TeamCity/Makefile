.PHONY: up stop volume

up: volume
	docker-compose up -d
	@echo "http://localhost:8111"

volume:
	docker volume create --name teamcity-data
	docker volume create --name teamcity-logs
	docker volume create --name teamcity-agent

stop:
	docker-compose stop
