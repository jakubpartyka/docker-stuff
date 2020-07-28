#!/bin/bash

#quick setup of Jenkins with BlueOcean plugin installed. Initial Jenkins admin password will be displayed after jenkins is installed. Docker should be installed. 

docker network create jenkins-network
docker volume create jenkins-docker-certs
docker volume create jenkins-data
docker container run --name jenkins-container -d --privileged --network jenkins-network --network-alias docker --env DOCKER_TLS_CERTDIR=/certs --volume jenkins-docker-ce$
docker container run --name jenkins-blueocean -d --network jenkins-network --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERI$
docker ps
echo
echo "INITIAL ADMIN PASSWORD: $(docker exec jenkins-container cat /var/jenkins_home/secrets/initialAdminPassword)"
