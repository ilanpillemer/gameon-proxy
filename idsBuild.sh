#!/bin/bash

#
# This script is only intended to run in the IBM DevOps Services Pipeline Environment.
#

echo Informing slack...
curl -X 'POST' --silent --data-binary '{"text":"A new build for the proxy has started."}' $WEBHOOK > /dev/null

echo Setting up Docker...
mkdir dockercfg ; cd dockercfg
echo -e $KEY > key.pem
echo -e $CA_CERT > ca.pem
echo -e $CERT > cert.pem
cd ..
wget http://security.ubuntu.com/ubuntu/pool/main/a/apparmor/libapparmor1_2.8.95~2430-0ubuntu5.3_amd64.deb -O libapparmor.deb
sudo dpkg -i libapparmor.deb
rm libapparmor.deb
wget https://get.docker.com/builds/Linux/x86_64/docker-1.9.1 --quiet -O docker
chmod +x docker

echo Downloading the certificate...
echo -e $GAMEON_CERT > proxy.pem 

echo Building the docker image...
./docker build -t gameon-proxy .
echo Stopping the existing container...
./docker stop -t 0 gameon-proxy
./docker rm gameon-proxy
echo Starting the new container...
./docker run -d -p 80:80 -p 443:443 -p 1936:1936 -p 9001:9001 -e LOGSTASH_ENDPOINT=$LOGSTASH_ENDPOINT -e ADMIN_PASSWORD=$ADMIN_PASSWORD -e PROXY_DOCKER_HOST=$PROXY_DOCKER_HOST --name=gameon-proxy gameon-proxy

rm -rf dockercfg