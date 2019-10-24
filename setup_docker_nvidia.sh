#!/bin/bash

#setup docker
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce=5:19.03.3~3-0~ubuntu-bionic docker-ce-cli=5:19.03.3~3-0~ubuntu-bionic containerd.io

echo Checking the installation

sudo docker run hello-world

echo Adding docker to group

sudo groupadd docker

sudo usermod -aG docker $USER

#setup nvidia
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo apt-get install nvidia-docker2
sudo pkill -SIGHUP dockerd
sudo systemctl restart docker

sudo usermod -aG audio $USER


echo please logout and log back in and run "docker run hello-world" in a terminal