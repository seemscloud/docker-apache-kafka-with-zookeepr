#!/bin/bash

export ZOO_LOG_DIR=${APPDIR}/logs

ls -lh

zkServer.sh --config "${APPDIR}/conf" start-foreground