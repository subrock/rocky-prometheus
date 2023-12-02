FROM rockylinux:9.2

LABEL maintainer="Karl Schroeder <karl@subrock.com>"

# Pre-reqs
RUN yum install -y vim nodejs npm net-tools iputils which procps chkconfig openssl-devel gcc glibc glibc-common wget unzip gd gd-devel perl autoconf gettext automake && yum clean all -y
COPY payload/influxdb.repo /etc/yum.repos.d/influxdb.repo
RUN yum install -y influxdb
#RUN influx -execute 'create database jmeter'
COPY payload/entrypoint.sh /
# Install Jmeter
#WORKDIR /tmp/
#RUN wget -O influxdb2-2.7.4_darwin_amd64.tar.gz https://dl.influxdata.com/influxdb/releases/influxdb2-2.7.4_darwin_amd64.tar.gz && tar xzf influxdb2-2.7.4_darwin_amd64.tar.gz -C /opt/
#RUN ln -s /opt/influxdb2-2.7.4/influxd /usr/local/bin/influxd

# Post-install
#COPY payload/prometheus.yml /opt/prometheus/
#RUN mkdir -p /var/node
COPY payload/start_node.sh /
#WORKDIR /var/node
#COPY payload/custom_config.tgz /tmp/
#RUN tar xfz /tmp/custom_config.tgz 
#COPY payload/start_all.sh /
#COPY payload/bbe.tgz /tmp/
#RUN tar xfz /tmp/bbe.tgz -C /opt/
#RUN ln -s /opt/blackbox_exporter-0.18.0.linux-amd64/ /opt/blackbox
COPY payload/.vimrc /root/

RUN echo -e "FLUXDB has started."

# Expose port so its available in desktop.
EXPOSE 8086

#CMD ["/bin/bash"]
ENTRYPOINT /entrypoint.sh && /bin/bash
#ENTRYPOINT influxd && /bin/bash
