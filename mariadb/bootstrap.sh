#!/bin/bash
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db \
  && sudo add-apt-repository 'deb [arch=amd64,i386] http://mirror6.layerjet.com/mariadb/repo/10.0/ubuntu trusty main' \
  && sudo apt-get update -qq \
  && sudo apt-get -q -y --force-yes install software-properties-common \
  && sudo apt-get -y remove libmysqlclient-dev mysql-client-5.5 mysql-client-core-5.5 \
  && sudo apt-get -q -y --force-yes install mariadb-server
