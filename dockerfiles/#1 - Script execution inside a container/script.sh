#!/bin/bash

#BELOW SCRIPT WILL BE EXECUTED INSIDE THE CONTAINER

echo "hello from inside a script"
while true ; do
sleep 10
echo "Container is alive: $(date)" >> /alive-log.log
done
