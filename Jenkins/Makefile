.PHONY: up stop clean clean-all

up:
	docker-compose up -d
	@echo "Starting the server.."
	@./wait_for_jenkins_login.sh
	@echo "Here's the initial admin password:"
	docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword || true
	@echo "http://localhost:8484"

stop:
	docker-compose stop

clean:
	docker-compose rm --stop --force

clean:
	docker-compose rm --stop --force -v

