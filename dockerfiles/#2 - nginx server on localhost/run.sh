#!/bin/bash
docker run --name nginx-server -v "$(pwd)"/src:/usr/share/nginx/html -d -p 80:80 nginx

# --name > set container's name
# -v > bind mount a volume to a container
# -d > detach container from stdout
# -p > forward port 80 from host to 80 on container
# nginx > Docker image to use
