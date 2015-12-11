#!/bin/bash
sudo apt-get install default-jre-headless \
    && curl -sS https://raw.githubusercontent.com/dreamhead/moco/master/moco-shell/moco > bin/moco \
    && chmod 0755 bin/moco \
    && bin/moco start -p $1 -c $2 > $3
