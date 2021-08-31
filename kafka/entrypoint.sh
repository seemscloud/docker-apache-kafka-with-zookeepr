#!/bin/bash

sed "s/ZOOKEEPER_HOSTS/${ZOOKEEPER_HOSTS}/g" -i config/server.properties
sed "s|DATA_DIR|${APPDIR}/data|g" -i config/server.properties
sed "s/BROKER_ID/${BROKER_ID}/g" -i config/server.properties

kafka-server-start.sh config/server.properties