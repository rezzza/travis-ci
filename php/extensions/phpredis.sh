#!/bin/sh
mkdir -p ~/.rezzza/php/extensions && cd ~/.rezzza/php/extensions \
    && git clone --depth=50 https://github.com/nicolasff/phpredis \
    && cd phpredis \
    && git checkout b2ffb7ac753f5fa94d808dbf684a64e9f0e6f8c5 \
    && phpize \
    && echo "Configuring phpredis..." \
    && ./configure > /dev/null \
    && echo "Building phpredis..." \
    && make -j4 > /dev/null \
    && echo "Installing phpredis..." \
    && sudo make install > /dev/null
