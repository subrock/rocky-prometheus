# rocky-prometheus
Prometheus on top of Rocky with Grafana. Both Prometheus and Grafana docker images ran fine. I was able to use the base images directly with the post deploy steps. But I wanted to experiment with running on top of RHEL or Rocky. I also wanted to a certain level of customization. For example to make dashboards and alerts persist without the need of a volume. 

Only files that are persisted are:
- /usr/share/grafana/grafana.db
- /etc/grafana/grafana.ini
- /opt/prometheus/prometheus.yml

## Run
```
docker network create --driver bridge prometheus-network
docker run -d --name PROMETHEUS --hostname PROMETHEUS -p 9090:9090 --network prometheus-network -t subrock/rocky-prometheus
docker run -d --name GRAFANA --hostname GRAFANA -p 9091:3000 --network prometheus-network -t subrock/rocky-grafana
docker run -d --name INFLUXDB --hostname INFLUXDB -p 8086:8086 -e DOCKER_INFLUXDB_INIT_MODE=setup -e DOCKER_INFLUXDB_INIT_USERNAME=admin -e DOCKER_INFLUXDB_INIT_PASSWORD=admin --network prometheus-network -t subrock/rocky-influxdb
```
'docker system prune' is your best friend.
## Compose
Using the files from this repo, you can build and launch using compose. Create a directory and place Dockerfile, docker-compose.yaml and startup.sh in a directory.
```
docker compose build
docker compose up
docker compose up -d
```
## Access
```
docker exec -it PROMETHEUS bash
docker exec -it GRAFANA bash
docker exec -it INFLUXDB bash
```
### Prometheus 
http://localhost:9090
### Grafana (Start Here) 
http://localhost:9091
### Influxdb 
http://localhost:8086
### Node_Exporter (Linux) 
http://<Client Ip>:9100
### Windows_Exporter (Windows) 
http://<Client Ip>:8350

## Node_Exporter
Node Exporter is used for linux machines. You can launch node_exporter agent on the PROMETHEUS node for testing and metrics. 
```
docker exec -it PROMETHEUS /start_node.sh
docker exec -it GRAFANA /start_node.sh
docker exec -it INFLUXDB /start_node.sh
```
Alternativly you can run it in the background
```
docker exec -it PROMETHEUS bash
/start_node.sh &
exit
```

## Prometheus Reload
This works, but can take time for it to complete polling. Restarting works too.
```
curl -s -XPOST localhost:9090/-/reload
or
docker restart PROMETHEUS
```
## Put it all together
Now we have PROMETHEUS for monitoring, GRAFANA for vistualizations and INFLUXDB for Integration with other apps like Jmeter. 

```
docker network create --driver bridge prometheus-network
docker run -d --name PROMETHEUS --hostname PROMETHEUS -p 9090:9090 --network prometheus-network -t subrock/rocky-prometheus
docker run -d --name GRAFANA --hostname GRAFANA -p 9091:3000 --network prometheus-network -t subrock/rocky-grafana
docker run -d --name INFLUXDB --hostname INFLUXDB -p 8086:8086 -e DOCKER_INFLUXDB_INIT_MODE=setup -e DOCKER_INFLUXDB_INIT_USERNAME=admin -e DOCKER_INFLUXDB_INIT_PASSWORD=admin --network prometheus-network -t subrock/rocky-influxdb
```
```
docker exec -it INFLUXDB influx -execute 'create database jmeter'
```
```
docker run --name CONTROLLER --hostname CONTROLLER --network prometheus-network -d -t subrock/rocky-jmeter:controller
docker run --name WORKER-1 --hostname WORKER-1 --network prometheus-network -d -t subrock/rocky-jmeter:worker
```
Wait a good 2 minutes for Exporters to sync. Then run tests using Jmeter GUI or distributed cluster. 
```
docker exec -it CONTROLLER /usr/local/bin/rocky-jmeter-run install_test_script.jmx
```
