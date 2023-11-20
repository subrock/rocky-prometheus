FROM rockylinux:9.2

LABEL maintainer="Karl Schroeder <karl@subrock.com>"

# Pre-reqs
#RUN yum install -y ca-certificates net-tools java-1.8.0-openjdk iputils nodejs npm which procps chkconfig openssl-devel gcc glibc glibc-common wget unzip httpd php gd gd-devel perl autoconf gettext automake && yum clean all -y
RUN yum install -y git nodejs npm net-tools iputils which procps chkconfig openssl-devel gcc glibc glibc-common wget unzip gd gd-devel perl autoconf gettext automake && yum clean all -y

# Install Jmeter
WORKDIR /tmp/
RUN wget -O prometheus-2.48.0.linux-amd64.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.48.0/prometheus-2.48.0.linux-amd64.tar.gz && tar xzf prometheus-2.48.0.linux-amd64.tar.gz -C /opt/
RUN ln -s /opt/prometheus-2.48.0.linux-amd64/ /opt/prometheus
#RUN cp -r /usr/local/apache-jmeter-5.6.2/* /usr/local/

COPY prometheus.yml /opt/prometheus/
RUN mkdir -p /var/node

COPY start_all.sh /
COPY bbe.tgz /tmp/
RUN tar xfz /tmp/bbe.tgz -C /opt/
RUN ln -s /opt/blackbox_exporter-0.18.0.linux-amd64/ /opt/blackbox

WORKDIR /opt/prometheus

# Expose port so its available in desktop.
EXPOSE 9090

#CMD ["/bin/bash"]
ENTRYPOINT /start_all.sh && /bin/bash
