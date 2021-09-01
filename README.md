# Docker Apache Kafka with ZooKeeper

## Zookeeper

### Brokers

```bash
zkCli.sh ls /brokers/ids

zkCli.sh delete /brokers/ids/1

zkCli.sh ls /brokers/topics
```

----
## Kafka

### Topics

#### List
```bash
kafka-topics.sh \
  --list \
  --zookeeper zookeeper1:2181 
```

#### Create
```bash
kafka-topics.sh \
  --topic example\
  --create \
  --zookeeper zookeeper1:2181 \
  --partitions 6 --replication-factor 3
```

#### Delete
```bash
kafka-topics.sh \
  --topic example \
  --delete \
  --zookeeper zookeeper1:2181
```

#### Describe
```bash
kafka-topics.sh \
  --topic example \
  --describe \
  --zookeeper zookeeper1:2181
```

#### Reassign Partitions
```bash
cat > reassign.json << "EndOfMessage"
{
  "partitions": [
    { "topic": "example","partition": 0, "replicas": [1,2]},
	{ "topic": "example","partition": 1, "replicas": [1,2]},
	{ "topic": "example","partition": 2, "replicas": [1,2]},
	{ "topic": "example","partition": 3, "replicas": [1,2]},
	{ "topic": "example","partition": 4, "replicas": [1,2]},
	{ "topic": "example","partition": 5, "replicas": [1,2]}
  ],
  "version":1
}
EndOfMessage

kafka-reassign-partitions.sh \
  --execute \
  --zookeeper zookeeper1:2181 \
  --reassignment-json-file reassign.json
```

#### Generate Reassignment
```bash
cat > topics.json << "EndOfMessage"
{
  "topics": [
    {"topic": "example"}
  ],
  "version":1
}
EndOfMessage

kafka-reassign-partitions.sh \
  --generate \
  --zookeeper zookeeper1:2181 \
  --topics-to-move-json-file topics.json \
  --broker-list "1,2,3"
  
kafka-reassign-partitions.sh \
  --execute \
  --zookeeper zookeeper1:2181 \
  --reassignment-json-file reassign.json
```

---
### Produce / Consume

#### Producer
```bash
kafka-console-producer.sh \
  --topic example \
  --broker-list localhost:9092 
```

#### Consumer
```bash
kafka-console-consumer.sh \
  --topic example \
  --from-beginning \
  --bootstrap-server localhost:9092
```

#### Perf Test
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