#!/bin/bash

echo "${ZOOKEEPER_ID}" > "${APPDIR}"/data/myid

sed "s/${HOSTNAME}/0.0.0.0/g" -i "${APPDIR}/conf/zoo.cfg"
sed "s|DATADIR|${APPDIR}|g" -i "${APPDIR}/conf/zoo.cfg"

zkServer.sh --config "${APPDIR}/conf" start-foreground