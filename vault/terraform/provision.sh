#!/bin/bash

sudo apt-get remove docker docker-engine docker.io;
sudo apt-get update;
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
sudo apt-key fingerprint 0EBFCD88;
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update;
yes | sudo apt-get install docker-ce;
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;
sudo chmod +x /usr/local/bin/docker-compose;

sudo apt-get install git;
sudo cd /opt
sudo mkdir github
sudo cd github/
sudo git clone https://github.com/dbuhtiyarov/k8s-demo.git
sudo cd /opt/github/k8s-demo/vault/terraform/

sudo cp -p vault.conf ./nginx/
sudo cp -p config.json ./vault/config/

sudo docker-compose up -d

