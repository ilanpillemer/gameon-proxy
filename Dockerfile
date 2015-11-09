FROM ubuntu:trusty

MAINTAINER Ben Smith (benjsmi@us.ibm.com)

ADD https://download.elastic.co/beats/filebeat/filebeat-1.0.0-rc1-x86_64.tar.gz /opt/filebeat.tar.gz

RUN cd /opt ; echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
    tee /etc/apt/sources.list.d/backports.list ; apt-get update ; apt-get install -y haproxy -t trusty-backports ; \
    mkdir -p /run/haproxy/ ; cd /opt ; tar xzf filebeat.tar.gz

COPY ./filebeat.yml /opt/filebeat-1.0.0-rc1-x86_64/filebeat.yml

COPY ./proxy.pem /etc/ssl/proxy.pem
COPY ./startup.sh /opt/startup.sh

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg

EXPOSE 80 443 1936

CMD ["/opt/startup.sh"]
