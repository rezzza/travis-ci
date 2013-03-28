#!/bin/sh
mkdir -p ~/.rezzza/php/extensions && cd ~/.rezzza/php/extensions \
    && git clone --depth=50 https://github.com/nicolasff/phpredis \
    && cd phpredis \
    && phpize \
    && echo "Configuring phpredis..." \
    && ./configure > /dev/null \
    && echo "Building phpredis..." \
    && make -j4 > /dev/null \
    && echo "Installing phpredis..." \
    && sudo make install > /dev/null
