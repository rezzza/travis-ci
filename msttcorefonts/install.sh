#!/bin/sh
sh -c "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections"
apt-get install ttf-mscorefonts-installer > /dev/null
