FROM ubuntu:trusty

MAINTAINER Ben Smith (benjsmi@us.ibm.com)

ADD http://game-on.org:8081/logstash-2.0.0.tar.gz /opt/
ADD http://game-on.org:8081/jdk-8u65-x64.tar.gz /opt/

RUN apt-get update ; apt-get install -y libc6-dev nano

RUN cd /opt ; echo "Extract Java..." ; tar xzf jdk-8u65-x64.tar.gz ; \
	echo "Extract Logstash..." ; tar xzf logstash-*.tar.gz ; \
	echo "Cleanup..." ; rm logstash-*.tar.gz jdk-8u65-x64.tar.gz ; \
	echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
    tee /etc/apt/sources.list.d/backports.list ; apt-get update ; apt-get install -y haproxy -t trusty-backports ; \
    touch /var/log/haproxy.log ; mkdir -p /run/haproxy/

COPY ./rsyslog.conf /etc/rsyslog.conf
COPY ./haproxy-rsyslog.conf /etc/rsyslog.d/49-haproxy.conf

COPY ./proxy.pem /etc/ssl/proxy.pem
COPY ./startup.sh /opt/startup.sh

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg

EXPOSE 80 443 1936

CMD ["/opt/startup.sh"]
