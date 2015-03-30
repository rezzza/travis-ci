#!/bin/sh
sudo apt-get update -qq
sudo apt-get install -q -y --force-yes apache2 libapache2-mod-fastcgi

# modules
sudo a2enmod rewrite actions vhost_alias auth_digest auth_basic
sudo a2dismod ssl

# sites
sudo a2dissite default

# specific confs
mkdir -p ~/vhosts
sudo echo "Listen $1" | sudo tee /etc/apache2/ports.conf
sudo cp ~/.rezzza.travis-ci/apache/conf.d/* /etc/apache2/conf.d/

sudo apache2ctl restart
