FROM ubuntu:18.04
MAINTAINER Alejandro Ferrari <support@wmconsulting.info>

RUN apt-get -y update && \
    apt-get install -y wget python-pip && \
    wget -q -O - http://apt.flussonic.com/binary/gpg.key | apt-key add - && \
    echo "deb http://apt.flussonic.com binary/" > /etc/apt/sources.list.d/flussonic.list && \
    apt-get update && \
    apt-get -y install flussonic flussonic-transcoder && \
    pip install supervisor && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD supervisord.conf /etc/supervisord.conf
ADD license.txt /etc/flussonic/license.txt

ENV TERM linux

VOLUME ["/var/log/flussonic"]
VOLUME ["/etc/flussonic"]

EXPOSE 80 8080 1935 554

CMD ["/usr/local/bin/supervisord"]
