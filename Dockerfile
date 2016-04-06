FROM haproxy:1.6

MAINTAINER Ben Smith (benjsmi@us.ibm.com)

RUN apt-get update && apt-get install -y wget ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/local/etc/haproxy /etc/
RUN mkdir /run/haproxy

RUN cd /opt ; echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
    tee /etc/apt/sources.list.d/backports.list ; apt-get update ; apt-get install -y wget ; apt-get install -y haproxy -t trusty-backports ; \
    mkdir -p /run/haproxy/
RUN wget https://github.com/coreos/etcd/releases/download/v2.2.2/etcd-v2.2.2-linux-amd64.tar.gz -q ; \
    tar xzf etcd-v2.2.2-linux-amd64.tar.gz etcd-v2.2.2-linux-amd64/etcdctl --strip-components=1 ; \
    rm etcd-v2.2.2-linux-amd64.tar.gz ; \
    mv etcdctl /usr/local/bin/etcdctl

COPY ./proxy.pem /etc/ssl/proxy.pem
COPY ./startup.sh /opt/startup.sh

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg
COPY ./haproxy-ics.cfg /etc/haproxy/haproxy-ics.cfg
COPY ./haproxy-dev.cfg /etc/haproxy/haproxy-dev.cfg

EXPOSE 80 443 1936

ENTRYPOINT ["/opt/startup.sh"]
CMD [""]
