# Shinken Docker installation using pip (latest)
FROM    ubuntu:bionic
RUN     apt-get update \
    && apt-get install python-pip python-pycurl -y

# Add user
RUN groupadd -r shinken && useradd --create-home --no-log-init -r -g shinken shinken

# Install dependencies
RUN apt-get update \
    && apt-get install nagios-plugins -y

# Install Shinken
RUN pip install shinken

# Install Nagio-SNMP Plugins
ADD http://nagios.manubulon.com/nagios-snmp-plugins.1.1.1.tgz /nagios-snmp-plugins.tgz
RUN tar -xvf nagios-snmp-plugins.tgz -C /tmp \
    && cd /tmp/nagios_plugins \
    && mkdir /var/lib/shinken && mkdir /var/lib/shinken/libexec/ \
    && cp check_snmp_*.pl /var/lib/shinken/libexec/ \ 
    && rm nagios-snmp-plugins.tgz \
    && rm -rfv /tmp/*

# VOLUME      ["/etc/shinken/custom_configs", "/usr/local/custom_plugins"]

ENTRYPOINT bash