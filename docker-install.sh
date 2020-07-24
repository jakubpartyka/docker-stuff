#!/bin/bash

# install Docker and add allow it to run without sudo prefix

echo "running apt-get update"
sudo apt-get update

echo "installing docker"
sudo apt-get install -y docker docker.io

echo "adding Docker to sudo group"
sudo groupadd docker
sudo usermod -aG docker $USER

echo
echo "docker installed with version:"
sudo docker version

echo
echo "please restart your console now"
