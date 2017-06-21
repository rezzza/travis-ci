#!/bin/sh
set -e

sudo sed -i -e 's/ edge/ edge test/' /etc/apt/sources.list.d/docker.list \
    && sudo apt-get update \
    && apt-cache madison docker-ce \
    && sudo apt-get -o Dpkg::Options::="--force-confnew" install -y docker-ce=${DOCKER_VERSION} \
    && sudo rm /usr/local/bin/docker-compose \
    && curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose \
    && chmod +x docker-compose \
    && sudo mv docker-compose /usr/local/bin \
    && docker version \
    && docker-compose version
