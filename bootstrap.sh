#!/bin/sh
set -e

apt-cache madison docker-engine \
    && sudo apt-get -o Dpkg::Options::="--force-confnew" install -y docker-engine=${DOCKER_VERSION} \
    && sudo rm /usr/local/bin/docker-compose \
    && curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose \
    && chmod +x docker-compose \
    && sudo mv docker-compose /usr/local/bin \
    && mkdir -p ~/docker-images \
    echo "DOCKER_OPTS=\"-g $HOME/docker-images $@\"\n" | sudo tee -a /etc/default/docker \
    && sudo service docker restart \
    && docker version \
    && docker-compose version \
    && docker images
