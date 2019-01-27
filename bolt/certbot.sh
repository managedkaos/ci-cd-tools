#!/bin/bash -xe
apt-get update
apt-get install -y software-properties-common
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install -y python-certbot-nginx
