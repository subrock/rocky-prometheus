#!/bin/sh

echo -n "Starting Prometheus..."
/opt/prometheus/prometheus --web.enable-lifecycle --config.file=/opt/prometheus/prometheus.yml &
echo Done
echo 

echo -n "Starting Blackbox Exporter... "
cd /opt/blackbox/
./blackbox_exporter --config.file=blackbox.yml &> ./output.log &

echo -n "Starting Node Exporter... "
cd /tmp/
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar xfz node_exporter-1.7.0.linux-amd64.tar.gz -C /opt/
cd /opt/
ln -s node_exporter-1.7.0.linux-amd64 node_exporter
cd /opt/node_exporter
/opt/node_exporter/node_exporter

echo 
echo ########################
echo ## PROMETHEUS Started ##
echo ########################
