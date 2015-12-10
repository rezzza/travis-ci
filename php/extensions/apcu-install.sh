#!/bin/bash
if [ $(phpenv version-name) = "7.0" ]; then 
  pickle install --defaults apcu-5.1.2 \
    && pushd . \
    && cd ~/ \
    && git clone https://github.com/krakjoe/apcu-bc.git \
    && cd apcu-bc \
    && git reset --hard 078a5742bed918665e66ac4f37583edc89a3e506 \
    && popd \
    && pickle install --defaults ~/apcu-bc ; 
else
    pickle install --defaults apcu-4.0.10
fi
    
printf "extension=apcu.so\n" | cat - ~/.rezzza.travis-ci/php/conf.d/apcu.ini > ~/.rezzza.travis-ci/php/conf.d/apc.ini

if [ $(phpenv version-name) = "7.0" ]; then 
  printf "nextension=apc.so\n" >> ~/.rezzza.travis-ci/php/conf.d/apc.ini 
fi

phpenv config-add ~/.rezzza.travis-ci/php/conf.d/apc.ini
