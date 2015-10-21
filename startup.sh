#!/bin/bash

sed -i s/PLACEHOLDER_PASSWORD/$ADMIN_PASSWORD/g /etc/haproxy/haproxy.cfg

service rsyslog start
haproxy -f /etc/haproxy/haproxy.cfg
tail -f /var/log/haproxy.log