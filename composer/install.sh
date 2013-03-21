#!/bin/sh
mkdir -p $HOME/bin \
    && curl -s https://getcomposer.org/installer | php -- --install-dir=$HOME/bin

export PATH=$HOME/bin:$PATH
