#!/bin/bash
sudo sh -c "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections" \
    && sudo apt-get --force-yes -y install ttf-mscorefonts-installer > /dev/null
