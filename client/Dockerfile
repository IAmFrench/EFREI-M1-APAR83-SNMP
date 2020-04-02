FROM ubuntu
RUN apt-get update \
    && apt-get install apt-utils -y \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install snmpd nano -y
EXPOSE 161/udp

COPY ./bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]