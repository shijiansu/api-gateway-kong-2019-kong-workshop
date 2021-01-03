docker run --network=kong-net --name logstash -d \
  -v /Users/degui/Kong/Workshops/Docker/logstash.conf:/usr/share/logstash/config/logstash.conf:ro \
  logstash:7.0.1 -f /usr/share/logstash/config/logstash.conf

docker run --network=kong-net --name elasticsearch -d \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "discovery.type=single-node" \
  elasticsearch:7.0.1

docker run --network=kong-net --name kibana -d -p 5601:5601 kibana:7.0.1
