FROM haproxy:1.6

MAINTAINER Ben Smith (benjsmi@us.ibm.com)

RUN apt-get update && apt-get install -y wget --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/local/etc/haproxy /etc/
RUN mkdir /run/haproxy

COPY ./proxy.pem /etc/ssl/proxy.pem
COPY ./startup.sh /opt/startup.sh

COPY ./haproxy.cfg /etc/haproxy/haproxy.cfg
COPY ./haproxy-dev.cfg /etc/haproxy/haproxy-dev.cfg

EXPOSE 80 443 1936

ENTRYPOINT ["/opt/startup.sh"]
CMD [""]
