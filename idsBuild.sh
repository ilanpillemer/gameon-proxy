#!/bin/bash

#
# This script is only intended to run in the IBM DevOps Services Pipeline Environment.
#

echo Informing slack...
curl -X 'POST' --data-binary '{"text":"A new build for the proxy has started."}' $WEBHOOK
echo Downloading the Docker binary...
wget http://game-on.org:8081/docker -O ./docker -q
echo Downloading the certificate...
wget http://game-on.org:8081/proxy.pem -O ./proxy.pem -q
chmod +x docker
export DOCKER_HOST="tcp://game-on.org:2375"
echo Building the docker image...
./docker build -t gameon-proxy .
echo Stopping the existing container...
./docker stop -t 0 gameon-proxy
./docker rm gameon-proxy
echo Starting the new container...
./docker run -d -p 80:80 -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin --name=gameon-proxy gameon-proxy