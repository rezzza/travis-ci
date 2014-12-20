#!/bin/sh
apt-get install -q -y --force-yes apache2 libapache2-mod-fastcgi

# modules
a2enmod rewrite actions vhost_alias auth_digest auth_basic
a2dismod ssl

# sites
a2dissite default

# specific confs
mkdir -p ~/vhosts
echo "Listen $1" | tee /etc/apache2/ports.conf
cp ~/.rezzza.travis-ci/apache/conf.d/* /etc/apache2/conf.d/

apache2ctl restart
