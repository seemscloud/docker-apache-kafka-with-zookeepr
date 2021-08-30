FROM ubuntu:focal

ARG KAFKA_VERSION
ARG APPDIR="/opt/app"

ENV DEBIAN_FRONTEND=noninteractive
ENV APPDIR=${APPDIR}
ENV PATH="/opt/kafka/${KAFKA_VERSION}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget openjdk-11-jdk -y

WORKDIR /tmp

RUN mkdir -p /opt/kafka/${KAFKA_VERSION} && \
    wget https://dlcdn.apache.org/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz -O apache-kafka.tar.gz && \
    tar -xf apache-kafka.tar.gz -C /opt/kafka/${KAFKA_VERSION} --strip-components=1 && \
    rm -f apache-kafka.tar.gz

RUN cat /opt/kafka/${KAFKA_VERSION}/config/log4j.properties

RUN useradd -s /bin/bash -m -d ${APPDIR} kafka && \
    chmod 700 ${APPDIR}

WORKDIR ${APPDIR}
USER kafka

RUN mkdir config logs && \
    chmod 700 *

COPY --chown=kafka ./files/log4j.properties config/
COPY --chown=kafka ./files/server.properties config/
COPY --chown=kafka entrypoint.sh .

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]