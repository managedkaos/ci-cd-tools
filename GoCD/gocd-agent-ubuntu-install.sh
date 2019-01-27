apt-get update
apt-get upgrade -y
echo "deb https://download.gocd.org /" > /etc/apt/sources.list.d/gocd.list
wget https://download.gocd.org/GOCD-GPG-KEY.asc
apt-key add GOCD-GPG-KEY.asc
sudo apt-get update
sudo apt-get install -y openjdk-8-jre
sudo apt-get install go-agent
