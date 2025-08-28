#!/bin/bash
#INSTALLING NEEDED PACKAGES 
apt-get -y update
apt-get -y install jq lvm2 python-is-python3 python3-simplejson python3-apt python3-pip s3cmd parted vnstat
#INSTALL DOCKER
apt-get -y remove docker docker-engine docker.io containerd runc
apt-get -y install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
usermod -aG docker ubuntu
if [[ ! -f /etc/docker/daemon.json ]]; then 
  echo '{ "log-driver": "json-file", "log-opts": { "max-size": "1024m", "max-file": "5" } }' >> /etc/docker/daemon.json
  systemctl restart docker
fi
#NTP SERVER
apt-get -y install chrony
sed -i 's/^#pool/pool/g'  /etc/chrony/chrony.conf