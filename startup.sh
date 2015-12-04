#!/bin/bash

if [ "$LOGSTASH_ENDPOINT" != "" ]; then
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_LOGHOST/$LOGSTASH_ENDPOINT/g /etc/haproxy/haproxy.cfg
  echo Starting haproxy...
  haproxy -f /etc/haproxy/haproxy.cfg
else
  echo No logging host set. HAProxy will not log.
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy-nolog.cfg
  sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy-nolog.cfg
  echo Starting haproxy with no logging, as none was defined.
  haproxy -f /etc/haproxy/haproxy-nolog.cfg
fi

