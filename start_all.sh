#!/bin/sh

echo -n "Starting Prometheus..."
/opt/prometheus/prometheus --web.enable-lifecycle --config.file=/opt/prometheus/prometheus.yml &
echo Done
echo 

echo -n "Starting Blackbox... "
cd /opt/blackbox/
./blackbox_exporter --config.file=blackbox.yml &> ./output.log &

echo Done
