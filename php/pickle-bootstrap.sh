#!/bin/bash
pushd . \
  && cd ~/ \
  && git clone https://github.com/FriendsOfPHP/pickle.git \
  && cd pickle \
  && git reset --hard 5ad1daf0396174d96d616b8b0b05c0979b85fd7d \
  && composer install --no-dev --optimize-autoloader \
  && curl -LSs http://box-project.github.io/box2/installer.php | php \
  && php -d phar.readonly=0 box.phar build \
  && sudo ln -s $(pwd)/bin/pickle /usr/bin/pickle \
  && popd
