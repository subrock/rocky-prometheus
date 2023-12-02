#!/bin/sh

echo -n "Starting Grafana..."
GF_AUTH_DISABLE_LOGIN_FORM=true GF_AUTH_ANONYMOUS_ENABLED=true GF_AUTH_ANONYMOUS_ORG_ROLE=Admin GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-polystat-panel,grafana-image-renderer grafana-server --config=/etc/grafana/grafana.ini --homepath /usr/share/grafana web &
echo 

echo -n "Starting Node Exporter... "
cd /tmp/
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xfz node_exporter-1.7.0.linux-amd64.tar.gz -C /opt/
cd /opt/
ln -s node_exporter-1.7.0.linux-amd64 node_exporter
cd /opt/node_exporter
/opt/node_exporter/node_exporter
echo 

echo ##################### 
echo ## GRAFANA Started ##
echo #####################

