#!/bin/bash
until [ $(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://127.0.0.1:8484) -eq 403 ]; do echo -n '.'; sleep 1; done
