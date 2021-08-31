# Docker Apache Kafka with ZooKeeper

## Zookeeper

### Brokers

```bash
zkCli.sh ls /brokers/ids
```

```bash
zkCli.sh delete /brokers/ids/1
```

### Topics

```bash
zkCli.sh ls /brokers/topics
```

## Kafka

### Topics

```bash
kafka-topics.sh \
  --list \
  --zookeeper zookeeper1:2181 
```

```bash
kafka-topics.sh \
  --topic example \
  --create \
  --zookeeper zookeeper1:2181 \
  --partitions 6 --replication-factor 1
```

```bash
kafka-topics.sh \
  --topic example \
  --delete \
  --zookeeper zookeeper1:2181
```

### Produce / Consume

```bash
kafka-console-producer.sh \
  --topic example \
  --broker-list localhost:9092 
```

```bash
kafka-console-consumer.sh \
  --topic example \
  --from-beginning \
  --bootstrap-server localhost:9092
```

```bash
kafka-producer-perf-test.sh \
  --topic example \
  --num-records 50000000 \
  --record-size 100 \
  --throughput -1 \
  --producer-props acks=1 \
  bootstrap.servers=localhost:9092 \
  buffer.memory=67108864 \
  batch.size=8196
```