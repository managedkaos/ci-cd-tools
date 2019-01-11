#!/bin/bash
until [ $(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://localhost:8484) -eq 403 ]; do echo -n '.'; sleep 1; done
echo
docker-compose logs | grep -A 2 "Please use the following password"
