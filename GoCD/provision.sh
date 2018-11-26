#!/bin/bash
echo '#########################################################'
echo '##  Provisioning the GoCD Server'
echo "##  Start time: $(date)"
echo '#########################################################'

echo 'deb https://download.gocd.org /' | tee /etc/apt/sources.list.d/gocd.list
curl https://download.gocd.org/GOCD-GPG-KEY.asc | apt-key add -

echo '##  Updating the apt cache'
apt-mark hold grub-common grub-pc grub-pc-bin grub2-common
apt-get update

echo '##  Installing Java Runtime Environment'
apt-get install -qq openjdk-8-jre

echo '##  Installing NGINX'
apt-get install -qq nginx
cp /vagrant/nginx.conf /etc/nginx/sites-available/default
systemctl reload nginx

echo '##  Installing GoCD Server'
apt-get install -qq go-server
/etc/init.d/go-server start

echo
echo '#########################################################'
echo '##  Installation complete!'
echo "##  End time: $(date)"
echo '#########################################################'
echo '##  Environment Summary'
echo '#########################################################'
echo "java      = $(java -version 2>&1 | grep version)"
echo "nginx     = $(nginx -v 2>&1)"
echo "go-server = "
echo '#########################################################'
echo
echo "##  Starting GoCD Server on ${PROJECT_URL}"
echo '##  Run 'vagrant ssh' to connect to the VM'
echo '##  Run 'vagrant status' for tips on working with the VM'
echo
