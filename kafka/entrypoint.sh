#!/bin/bash

export LOG_DIR="${APPDIR}/logs"

sed "s/ZOOKEEPER_HOSTS/${ZOOKEEPER_HOSTS}/g" -i config/server.properties
sed "s/DATA_DIR/${APPDIR}\/data/g" -i config/server.properties

kafka-server-start.sh config/server.properties
