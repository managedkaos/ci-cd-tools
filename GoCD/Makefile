.PHONY: up stop clean clean-all

up:
	docker-compose up -d
	@echo "http://localhost:8153"

stop:
	docker-compose stop

clean:
	docker-compose rm --stop --force

clean-all:
	docker-compose rm --stop --force -v

