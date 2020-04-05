FROM ubuntu
RUN apt-get update \
    && apt-get install apt-utils -y \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install snmpd nano -y


RUN apt-get install snmp-mibs-downloader -y \
    && download-mibs

EXPOSE 161/udp

COPY ./bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]