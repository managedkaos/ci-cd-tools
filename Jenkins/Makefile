.PHONY: up stop volume

up: volume
	docker-compose up -d
	@echo "Starting the server.."
	@./wait_for_jenkins_login.sh
	@echo "Here's the initial admin password:"
	docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword || true
	@echo "http://localhost:8484"

volume:
	docker volume create --name jenkins-data

stop:
	docker-compose stop
