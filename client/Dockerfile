FROM ubuntu
RUN apt update \
    && apt-get install snmpd -y \
    && service snmpd start
EXPOSE 600-601
ENTRYPOINT ["/bin/bash"]