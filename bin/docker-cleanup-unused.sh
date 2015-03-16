#!/bin/sh
# docker-cleanup-unused.sh -- cleanup docker containers and images

docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm
docker images | awk '$1 == "<none>" {print $3}' | xargs docker rmi
