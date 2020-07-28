#!/bin/bash

#RUN THIS SCRIPT TO BUILD AND RUN A DOCKER IMAGE

#name of Docker image to build
IMG_NAME='script-runner'

#name of Docker container to run
CTR_NAME='script-runner-container'

#build image, create container and open bash inside the container
sudo docker build -t $IMG_NAME .
sudo docker run -d --name $CTR_NAME $IMG_NAME
sudo docker exec -it $CTR_NAME /bin/bash
