FROM tutum/curl:trusty
MAINTAINER Jose Luis Illana Ruiz <joseluisillana@gmail.com>

# Install InfluxDB over Virtual Machine privided by VirtualBox
ENV INFLUXDB_VER latest
ENV INFLUXDB_ARCH_VER latest

# We need to download the installation files from AWS S3
RUN curl -s -o /tmp/influxdb_${INFLUXDB_VER}_${INFLUXDB_ARCH_VER}https://s3.amazonaws.com/influxdb/influxdb_${INFLUXDB_VER}_${INFLUXDB_ARCH_VER}.deb && \
  dpkg -i /tmp/influxdb_${INFLUXDB_VER}_${INFLUXDB_ARCH_VER}.deb && \
  rm /tmp/influxdb_${INFLUXDB_VER}_${INFLUXDB_ARCH_VER}.deb && \
  rm -rf /var/lib/apt/lists/*

# TODO - Verify using of the next line
ADD exampledata/types.db /usr/share/collectd/types.db

ADD configurations/config.toml /config/config.toml
ADD configurations/run.sh /run.sh
RUN chmod +x /*.sh

ENV PRE_CREATE_DB **None**
ENV SSL_SUPPORT **False**
ENV SSL_CERT **None**

# Need to expose the 'Admin server WebUI' port
EXPOSE 8083

# Need to expose the 'HTTP API' port
EXPOSE 8086

# Need to expose the 'HTTPs API' port
EXPOSE 8084

# About clustering, 
# This is the 'Raft' port. 
# For clustering, don't expose publicly for security reasons
#EXPOSE 8090

# About clustering, 
# This is the 'Protobuf' port. 
# For clustering, don't expose publicly for security reasons
#EXPOSE 8099

# Mounting the volume for the data.
VOLUME ["/data"]

# Executing initialization script 
CMD ["/run.sh"]
