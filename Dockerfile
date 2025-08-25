FROM n8nio/n8n:latest

USER root

RUN apt-get update && \
    apt-get install -y libaio1 unzip wget && \
    mkdir -p /opt/oracle && \
    cd /opt/oracle && \
    wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux.x64-21.1.0.0.0.zip && \
    unzip instantclient-basiclite-linux.x64-21.1.0.0.0.zip && \
    rm instantclient-basiclite-linux.x64-21.1.0.0.0.zip && \
    echo /opt/oracle/instantclient_21_1 > /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient_21_1:$LD_LIBRARY_PATH"

USER node
RUN npm install n8n-nodes-oracledb oracledb
