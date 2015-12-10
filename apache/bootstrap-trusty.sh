#!/bin/bash
printf "deb http://nova.clouds.archive.ubuntu.com/ubuntu/ trusty multiverse\ndeb http://nova.clouds.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" | sudo tee -ai /etc/apt/sources.list.d/rezzza-ubuntu-multiverse.list \
  && sudo apt-get update -qq \
  && sudo apt-get install -q -y --force-yes apache2 libapache2-mod-fastcgi \
  && sudo a2enmod actions auth_basic auth_digest deflate fastcgi headers rewrite vhost_alias \
  && sudo a2dissite 000-default \
  && sudo chmod a+rx /home/travis \
  && sudo mkdir -p /etc/apache2/conf.d/ \
  && sudo echo "Listen $1" | sudo tee /etc/apache2/ports.conf \
  && sudo cp ~/.rezzza.travis-ci/apache/conf.d/* /etc/apache2/conf.d/ \
  && sudo echo "ServerName localhost" | sudo tee /etc/apache2/conf-enabled/httpd.conf \
  && sudo echo "Include /etc/apache2/conf.d/*" | sudo tee /etc/apache2/conf-enabled/include.conf \
  && sudo chmod 0777 /etc/apache2/conf-enabled/include.conf && sudo chmod 0777 /etc/apache2/conf-enabled/httpd.conf \
  && mkdir -p ~/vhosts \
  && sudo service apache2 restart
