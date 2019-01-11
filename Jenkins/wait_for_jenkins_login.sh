#!/bin/sh
until [ $(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://jenkins-server:8484) -eq 403 ]; do echo -n '.'; sleep 1; done
