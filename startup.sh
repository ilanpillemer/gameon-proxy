#!/bin/bash

if [ "$ETCDCTL_ENDPOINT" != "" ]; then
  echo Setting up etcd...
  wget https://github.com/coreos/etcd/releases/download/v2.2.2/etcd-v2.2.2-linux-amd64.tar.gz -q
  tar xzf etcd-v2.2.2-linux-amd64.tar.gz etcd-v2.2.2-linux-amd64/etcdctl --strip-components=1
  rm etcd-v2.2.2-linux-amd64.tar.gz
  mv etcdctl /usr/local/bin/etcdctl

  etcdctl get /proxy/third-party-ssl-cert > /etc/ssl/proxy.pem
  sed -i s/PLACEHOLDER_PASSWORD/$(etcdctl get /passwords/admin-password)/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_DOCKERHOST/$(etcdctl get /proxy/docker-host)/g /etc/haproxy/haproxy.cfg
  sed -i s/PLACEHOLDER_LOGHOST/$(etcdctl get /logstash/endpoint)/g /etc/haproxy/haproxy.cfg
  echo Starting haproxy...
  haproxy -f /etc/haproxy/haproxy.cfg
else
  echo HAProxy will log to STDOUT--this is dev environment.
  sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy-dev.cfg
  haproxy -f /etc/haproxy/haproxy-dev.cfg
fi
