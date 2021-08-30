#!/bin/bash

export LOG_DIR="${APPDIR}/logs"

kafka-server-start.sh config/server.properties
