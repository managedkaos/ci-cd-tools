FROM jenkins/jenkins:lts
USER root
RUN apt-get update && \
	apt-get install -y make python-pip python3 python3-pip && \
	pip install virtualenv && \
        pip3 install virtualenv
USER jenkins
