#!/bin/bash
until [ $(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://localhost:8484) -eq 403 ]; do echo -n '.'; sleep 1; done
echo
docker logs jenkins-server 2>&1| grep -A 2 "Please use the following password"
