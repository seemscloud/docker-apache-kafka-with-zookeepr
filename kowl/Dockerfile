FROM ubuntu:focal

ARG GO_VERSION
ARG NODE_VERSION
ARG KOWL_VERSION
ARG APPDIR="/opt/app"

ENV DEBIAN_FRONTEND=noninteractive

ENV APPDIR=${APPDIR}
ENV PATH="/opt/go/${GO_VERSION}/bin:${PATH}"
ENV PATH="/opt/node/${NODE_VERSION}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget xz-utils -y

WORKDIR /tmp

RUN mkdir -p /opt/go/${GO_VERSION} && \
    wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz -O go.tar.gz && \
    tar -xf go.tar.gz -C /opt/go/${GO_VERSION} --strip-components=1 && \
    rm -f go.tar.gz

RUN mkdir -p /opt/node/${NODE_VERSION} && \
    wget https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -O node.tar.xz && \
    tar -xf node.tar.xz -C /opt/node/${NODE_VERSION} --strip-components=1 && \
    rm -f node.tar.xz

RUN wget https://github.com/cloudhut/kowl/archive/refs/tags/v1.4.0.tar.gz -O kowl.tar.gz && \
    tar -xf kowl.tar.gz -C . --strip-components=1 && \
    rm -f kowl.tar.gz

RUN useradd -s /bin/bash -m -d ${APPDIR} kowl && \
    chmod 700 ${APPDIR}

RUN cd backend && \
    go mod download && \
    CGO_ENABLED=0 go build -o ./bin/kowl ./cmd/api && \
    mv bin/kowl ${APPDIR}

RUN cd frontend && \
    npm install && \
    npm run build && \
    mv build ${APPDIR} && \
    chown kowl:kowl -R ${APPDIR}

WORKDIR ${APPDIR}
USER kowl

COPY --chown=kowl ./entrypoint.sh .

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]