#!/bin/bash

echo Replacing password in...
sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy.cfg
sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy.cfg
sed -i s/PLACEHOLDER_DOCKERHOST/$LOGGING_DOCKER_HOST/g /opt/filebeat-1.0.0-rc1-x86_64/filebeat.yml
echo Starting haproxy in the background...
haproxy -f /etc/haproxy/haproxy.cfg
echo Starting Filebeat...
/opt/filebeat-1.0.0-rc1-x86_64/filebeat -e -c /opt/filebeat-1.0.0-rc1-x86_64/file