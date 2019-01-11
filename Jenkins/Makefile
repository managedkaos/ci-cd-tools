PORT=8484
up:
	docker-compose up -d

	docker logs jenkins-server 2>&1| grep -A 2 "Please use the following password"
	@echo "http://localhost:$(PORT)"

stop:
	docker-compose stop

clean:
	docker-compose rm --stop --force

clean-all:
	docker-compose rm --stop --force -v

.PHONY: up stop clean clean-all
