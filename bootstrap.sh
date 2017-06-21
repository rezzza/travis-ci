#!/bin/sh
set -e

if [ ! -z "$DOCKER_TEST_CHANNEL" ]
then
    sudo sed -i -e 's/ edge/ edge test/' /etc/apt/sources.list.d/docker.list
    sudo apt-get update
fi

# docker-ce
apt-cache madison docker-ce
sudo apt-get -o Dpkg::Options::="--force-confnew" install -y docker-ce=${DOCKER_VERSION}
mkdir -p ~/docker-images
echo "DOCKER_OPTS=\"-g $HOME/docker-images\"\n" | sudo tee -a /etc/default/docker
cat /etc/default/docker
sudo service docker restart

# docker-compose
sudo rm /usr/local/bin/docker-compose
curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin

# installed versions summary
docker version
docker-compose version
