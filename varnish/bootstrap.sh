#!/bin/bash
curl https://repo.varnish-cache.org/GPG-key.txt | sudo apt-key add - \
    && printf "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0\n" | sudo tee -ai /etc/apt/sources.list.d/varnish-cache.list \
    && sudo apt-get update -qq \
    && sudo apt-get install -q -y --force-yes varnish \
    && sudo cp ~/.rezzza.travis-ci/varnish/libvmod_curl.so /usr/lib/varnish/vmods/libvmod_curl.so \
    && sudo service varnish stop \
    && sudo rm -rf /var/lib/varnish/* \
    && sudo varnishd -a 127.0.0.1:$1 -s file,/tmp,500M -f $2 -p vcl_dir=$3