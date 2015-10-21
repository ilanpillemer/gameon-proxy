FROM ubuntu:trusty

MAINTAINER Ben Smith

RUN echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
      tee /etc/apt/sources.list.d/backports.list ; apt-get update ; apt-get install -y haproxy -t trusty-backports ; \
      touch /var/log/haproxy.log ; mkdir -p /run/haproxy/

COPY ./rsyslog.conf /etc/rsyslog.conf
COPY ./haproxy-rsyslog.conf /etc/rsyslog.d/49-haproxy.conf

COPY ./proxy.pem /etc/ssl/proxy.pem
COPY ./startup.sh /opt/startup.sh

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg

EXPOSE 80
EXPOSE 443
EXPOSE 1936

CMD ["/opt/startup.sh"]
