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
kafka-topics.sh --list --zookeeper zookeeper1:2181
```

```bash
for i in `seq 0 10` ; do
  kafka-topics.sh --create --zookeeper zookeeper1:2181 --replication-factor 2 --partitions 3 --topic "example${i}"
done
```

```bash
for i in `seq 0 10` ; do
  kafka-topics.sh --delete --zookeeper zookeeper1:2181 --topic "example${i}"
done
```

### Produce / Consume

```bash
kafka-console-producer.sh --topic example0 --broker-list localhost:9092 
```

```bash
kafka-console-consumer.sh --topic example0 --from-beginning --bootstrap-server localhost:9092
```