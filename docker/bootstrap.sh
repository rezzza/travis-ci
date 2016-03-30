#!/bin/sh
set -e

# Do not forgot to add the DOCKER_VERSION and DOCKER_COMPOSE_VERSION env
# variables in the .travis.yml:
#
# ```
# env:
#     global:
#         - DOCKER_VERSION=1.10.3-0~trusty
#         - DOCKER_COMPOSE_VERSION=1.6.2
# ```

apt-cache madison docker-engine \
    && sudo apt-get -o Dpkg::Options::="--force-confnew" install -y docker-engine=${DOCKER_VERSION} \
    && sudo rm /usr/local/bin/docker-compose \
    && curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose \
    && chmod +x docker-compose \
    && sudo mv docker-compose /usr/local/bin \
    && sudo mkdir -p /var/lib/docker-images \
    && printf "DOCKER_OPTS=\"-g /var/lib/docker-images\"\n" | sudo tee -a /etc/default/docker \
    && sudo service docker restart \
    && docker version \
    && docker-compose version \
    && docker images
