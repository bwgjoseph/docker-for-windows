# Pre-setup

If you wish to create data volume and manage externally:

```
docker volume create od_kakfa_lib
```

# Startup

Run `docker-compose up -d`

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

Launch your browser, and navigate to `http://localhost:9014`

Current version of `kafdrop` does not support adding topic via UI [coming soon via [PR#45](https://github.com/obsidiandynamics/kafdrop/pull/45)]

To add a topic
  - docker exec -it od-kafka bash
  - cd /opt/kafka/bin

```
./kafka-topics.sh --bootstrap-server localhost:9092 \
    --create --partitions 3 --replication-factor 1 \
    --topic streams-intro
```

To publish message

```
./kafka-console-producer.sh --broker-list localhost:9092 \
    --topic streams-intro --property "parse.key=true" \
    --property "key.separator=:"
```

Test message:

```
foo:first message
foo:second message
bar:first message
foo:third message
bar:second message
```

# References

- [introduction-to-event-streaming-with-kafka-and-kafdrop](https://dev.to/ekoutanov/introduction-to-event-streaming-with-kafka-and-kafdrop-38n1)
- [reintroducing-kafdrop-3](https://itnext.io/reintroducing-kafdrop-3-9e5856719357)
- [kafdrop-an-open-source-kafka-web-ui](https://dev.to/ekoutanov/kafdrop-an-open-source-kafka-web-ui-mbn)