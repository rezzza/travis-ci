#!/bin/sh
sudo sh -c "echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections"
sudo apt-get install ttf-mscorefonts-installer > /dev/null

#mkdir -p ~/.downloads/debs \
#    && curl http://imaginux.com/repos/pool/renzo/msttcorefonts-offline_1.0-0ubuntu1_all.deb \
#    -o ~/.downloads/msttcorefonts-offline_1.0-0ubuntu1_all.deb \
#    && sudo dpkg -i ~/.downloads/msttcorefonts-offline_1.0-0ubuntu1_all.deb
