# rocky-prometheus
Prometheus on top of Rocky with Grafana

## Run
```
docker network create --driver bridge prometheus-network
docker run -d --name PROMETHEUS --hostname PROMETHEUS -p 9090:9090 --network prometheus-network -t rocky-prometheus
docker run -d --name GRAFANA --hostname GRAFANA -p 9091:3000 --network prometheus-network -t rocky-grafana
```

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
http://localhost:9090

http://localhost:9091

http://localhost:9100

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
```
curl -s -XPOST localhost:9090/-/reload
```

