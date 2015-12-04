#!/bin/bash

if [ "$ADMIN_PASSWORD" == "" ] || [ "$PROXY_DOCKER_HOST" == ""]; then
  echo "One or more required environment variables is not set; please review README.md for more information."
  exit 1
fi

if [ "$LOGGING_DOCKER_HOST" != "" ]; then
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_LOGHOST/$LOGSTASH_ENDPOINT/g /etc/haproxy/haproxy.cfg
  echo Starting haproxy-- foreground mode.
  haproxy -f /etc/haproxy/haproxy.cfg
else
  echo No logging host set. HAProxy will not log.
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy-nolog.cfg
  sed -i s/PLACEHOLDER_DOCKERHOST/$PROXY_DOCKER_HOST/g /etc/haproxy/haproxy-nolog.cfg
  haproxy -f /etc/haproxy/haproxy-nolog.cfg
fi

