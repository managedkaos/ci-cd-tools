PORT=8153
up:
	docker-compose up --detach --build
	@echo "http://localhost:$(PORT)"

stop:
	docker-compose stop

clean:
	docker-compose rm --stop --force

clean-all:
	docker-compose rm --stop --force -v

.PHONY: up stop clean clean-all
