# rocky-prometheus
Prometheus on top of Rocky with Grafana

## Run
```
docker network create --driver bridge prometheus-network
docker run -d --name PROMETHEUS --hostname PROMETHEUS -p 9090:9090 --network prometheus-network -t subrock/rocky-prometheus
docker run -d --name GRAFANA --hostname GRAFANA -p 9091:3000 --network prometheus-network -t subrock/rocky-grafana
```
docker system prune is your best friend.
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
```
### Prometheus 
http://localhost:9090
### Grafana (Start Here) 
http://localhost:9091
### Node_Exporter (Linux) 
http://<Client Ip>:9100
### Windows_Exporter (Windows) 
http://<Client Ip>:8350

## Node_Exporter
Node Exporter is used for linux machines. You can launch node_exporter agent on the PROMETHEUS node for testing and metrics. 
```
docker exec -it PROMETHEUS /start_node.sh
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
docker restart GRAFANA
```

