FROM ubuntu:focal

ARG ZOOKEEPER_VERSION
ARG APPDIR="/opt/app"

ENV DEBIAN_FRONTEND=noninteractive
ENV APPDIR=${APPDIR}
ENV PATH="/opt/zookeeper/${ZOOKEEPER_VERSION}/bin:${PATH}"
ENV ZOO_LOG_DIR=${APPDIR}/logs

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget openjdk-11-jdk -y

WORKDIR /tmp

RUN mkdir -p /opt/zookeeper/${ZOOKEEPER_VERSION} && \
    wget https://dlcdn.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -O apache-zookeeper.tar.gz && \
    tar -xf apache-zookeeper.tar.gz -C /opt/zookeeper/${ZOOKEEPER_VERSION} --strip-components=1 && \
    rm -f apache-zookeeper.tar.gz

RUN useradd -s /bin/bash -m -d ${APPDIR} zookeeper && \
    chmod 700 ${APPDIR}

WORKDIR ${APPDIR}
USER zookeeper

RUN mkdir -p conf logs data && \
    chmod 700 *

COPY --chown=zookeeper ./files/zoo.cfg conf/
COPY --chown=zookeeper ./files/log4j.properties conf/
COPY --chown=zookeeper entrypoint.sh .

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]