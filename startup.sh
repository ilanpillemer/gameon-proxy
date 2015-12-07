#!/bin/bash

if [ "$LOGSTASH_ENDPOINT" != "" ]; then
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_LOGHOST/$LOGSTASH_ENDPOINT/g /etc/haproxy/haproxy.cfg
  echo Starting haproxy...
  haproxy -f /etc/haproxy/haproxy.cfg
else
  echo HAProxy will log to STDOUT--this is dev environment.
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy-dev.cfg
  haproxy -f /etc/haproxy/haproxy-dev.cfg
fi

