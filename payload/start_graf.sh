#!/bin/sh

echo -n "Starting Grafana..."
GF_AUTH_DISABLE_LOGIN_FORM=true GF_AUTH_ANONYMOUS_ENABLED=true GF_AUTH_ANONYMOUS_ORG_ROLE=Admin GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-polystat-panel,grafana-image-renderer grafana-server --config=/etc/grafana/grafana.ini --homepath /usr/share/grafana web &
echo 
echo ##################### 
echo ## GRAFANA Started ##
echo #####################

