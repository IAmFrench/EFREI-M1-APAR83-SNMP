FROM ubuntu
RUN apt update \
    && apt-get install snmpd -y \
    && service snmpd start
ENTRYPOINT ["/bin/bash"]