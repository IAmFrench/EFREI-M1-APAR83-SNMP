FROM    ubuntu:bionic
RUN apt-get update \
    && apt-get install build-essential checkinstall apt-utils -y \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y

# Install python 2.7
RUN apt-get install python2.7 -y

# Install Python tools
RUN apt-get install python-pip -y
RUN apt-get install python-pycurl python-wheel python-cherrypy python-setuptools -y

# Create user and group for shinken
RUN groupadd -r shinken && useradd --create-home --no-log-init -r -g shinken shinken

# Build from sources... because pip install is bugged as f*ck
ADD https://github.com/naparuba/shinken/archive/2.4.3.tar.gz /shinken-2-4-3.tar.gz
RUN tar -xvf shinken-2-4-3.tar.gz -C /tmp \
    && cd /tmp/shinken-2.4.3
WORKDIR /tmp/shinken-2.4.3
RUN python setup.py install
WORKDIR /
RUN rm shinken-2-4-3.tar.gz \
    && rm -rfv /tmp/*

# Init shinken
RUN su - shinken -c 'shinken --init' \
    && su - shinken -c 'shinken install webui2' \
    && su - shinken -c 'shinken install linux-snmp'

# install webui2
RUN pip install pymongo>=3.0.3 requests arrow bottle==0.12.8
RUN apt-get install mongodb -y
COPY ./config/webui2.cfg /etc/shinken/modules/webui2.cfg
COPY ./config/broker-master.cfg /etc/shinken/brokers/broker-master.cfg
ADD https://raw.githubusercontent.com/Sysnove/shinken-plugins/master/check_netint.pl /var/lib/shinken/libexec/check_netint.pl
RUN chmod 755 /var/lib/shinken/libexec/check_netint.pl
COPY ./config/linux_host.cfg /etc/shinken/templates/linux_host.cfg
RUN chmod 755 /etc/shinken/templates/linux_host.cfg

# Install nagios
RUN apt-get install nagios-plugins* cpanminus -y
RUN cpanm Net::SNMP \
    && cpanm Time::HiRes \
    && cpanm DBI
RUN chmod u+s /usr/lib/nagios/plugins/check_icmp \
    && ln -s /usr/lib/nagios/plugins/utils.pm /var/lib/shinken/libexec/

# Install locales
RUN echo ${LC_ALL} \
    && apt-get install -y locales \
    && locale-gen ${LC_ALL:-en_US.utf8} \
    && update-locale LANG=${LC_ALL}

# Create the log directory
RUN mkdir -p /var/log/rhosts/ \
    && touch /var/log/rhosts/remote-hosts.log

# Fix righs issues with
RUN chown -R shinken:shinken /var/lib/shinken/ \
    && chown -R shinken:shinken /etc/shinken/

# Copy startup script
COPY ./bootstrap.sh /bootstrap.sh

EXPOSE 80/udp

ENTRYPOINT ["/bootstrap.sh"]
#ENTRYPOINT bash