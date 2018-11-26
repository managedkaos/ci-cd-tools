#!/bin/bash
export BAMBOO_VERSION=6.7.1
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

echo '#########################################################'
echo "##  Provisioning Bamboo Server ${BAMBOO_VERSION}"
echo "##  Start time: $(date)"
echo '#########################################################'

echo '##  Updating the apt cache'
apt-mark hold grub-common grub-pc grub-pc-bin grub2-common
apt-get update

echo '##  Installing Java Runtime Environment'
apt-get install -qq default-jdk

echo '##  Installing NGINX'
apt-get install -qq nginx
cp /vagrant/nginx.conf /etc/nginx/sites-available/default
systemctl reload nginx

echo '##  Installing Bamboo Server'
wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz -O /tmp/bamboo.tar.gz
tar -xvzf /tmp/bamboo.tar.gz -C /opt
mkdir /root/bamboo_home
cp /vagrant/bamboo-init.properties /opt/atlassian-bamboo-${BAMBOO_VERSION}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
cd /opt/atlassian-bamboo-${BAMBOO_VERSION} && bin/start-bamboo.sh

echo
echo '#########################################################'
echo '##  Installation complete!'
echo "##  End time: $(date)"
echo '#########################################################'
echo '##  Environment Summary'
echo '#########################################################'
echo "java      = $(java -version 2>&1 | grep version)"
echo "nginx     = $(nginx -v 2>&1)"
echo "bamboo     = "
echo '#########################################################'
echo
echo "##  Starting Bamboo Server on ${PROJECT_URL}"
echo '##  Run 'vagrant ssh' to connect to the VM'
echo '##  Run 'vagrant status' for tips on working with the VM'
echo
