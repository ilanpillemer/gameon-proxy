#!/bin/bash

echo Replacing password in...
sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy.cfg
sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy.cfg
echo Starting haproxy in the background...
haproxy -f /etc/haproxy/haproxy.cfg
echo Running logstash...
export JAVA_HOME=/opt/jdk1.8.0_65/
/opt/logstash-2.0.0/bin/logstash -f /opt/logstash-2.0.0/logstash.conf
