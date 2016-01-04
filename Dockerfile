FROM ubuntu:trusty

MAINTAINER Ben Smith (benjsmi@us.ibm.com)

RUN cd /opt ; echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
    tee /etc/apt/sources.list.d/backports.list ; apt-get update ; apt-get install -y wget ; apt-get install -y haproxy -t trusty-backports ; \
    mkdir -p /run/haproxy/

COPY ./proxy.pem /etc/ssl/proxy.pem
COPY ./startup.sh /opt/startup.sh

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg
COPY ./haproxy-dev.cfg /etc/haproxy/haproxy-dev.cfg

EXPOSE 80 443 1936

CMD ["/opt/startup.sh"]
