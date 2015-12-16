#!/bin/bash
set -e

bootstrap_base()
{
    phpenv config-add ~/.rezzza.travis-ci/php/conf.d/rezzza.ini \
        && rm -rf ~/.phpenv/versions/$(phpenv version-name)/etc/conf.d/xdebug.ini \
        && [[ $(php -r "echo extension_loaded('Zend OPcache');") != "1" ]] && phpenv config-add ~/.rezzza.travis-ci/php/conf.d/opcode.ini

    # for github anonymous request limit issue
    if [ -d .composer ] ; then
        cp -rpf .composer ~/
    fi
}

bootstrap_pickle()
{
    # install pickle if not installed
    test_pickle=$(which pickle)
    if [ $? -ne 0 ] ; then
        printf "Pickle is not installed.\n"
        pushd . \
          && cd ~/ \
          && git clone https://github.com/FriendsOfPHP/pickle.git \
          && cd pickle \
          && git reset --hard 5ad1daf0396174d96d616b8b0b05c0979b85fd7d \
          && composer install --no-dev --optimize-autoloader --prefer-dist \
          && curl -LSs http://box-project.github.io/box2/installer.php | php \
          && php -d phar.readonly=0 box.phar build \
          && sudo ln -s $(pwd)/bin/pickle /usr/bin/pickle \
          && popd
        printf "Pickle successfuly installed."
    fi
}

bootstrap_apcu()
{
    if [ $(php -r "echo extension_loaded('apcu');") = "1" ] ; then
        return;
    fi
    
    # manage apcu install subtilities between php >= 7.0 and others
    if [ $(phpenv version-name) = "7.0" ]; then
      pickle install --defaults apcu-5.1.2 \
        && mkdir -p ~/.rezzza/php/extensions \
        && pushd . \
        && cd ~/.rezzza/php/extensions \
        && git clone https://github.com/krakjoe/apcu-bc.git \
        && cd apcu-bc \
        && git reset --hard 078a5742bed918665e66ac4f37583edc89a3e506 \
        && popd \
        && pickle install --defaults ~/.rezzza/php/extensions/apcu-bc
    else
      pickle install --defaults apcu-4.0.10
    fi

    printf "extension=apcu.so\n" | cat - ~/.rezzza.travis-ci/php/conf.d/apcu.ini > ~/.rezzza.travis-ci/php/conf.d/apc.ini

    if [ $(phpenv version-name) = "7.0" ]; then
      printf "extension=apc.so\n" >> ~/.rezzza.travis-ci/php/conf.d/apc.ini
    fi

    phpenv config-add ~/.rezzza.travis-ci/php/conf.d/apc.ini
}

bootstrap_redis()
{
    if [ $(php -r "echo extension_loaded('redis');") = "1" ] ; then
        return;
    fi
    
    if [ $(phpenv version-name) = "7.0" ]; then
        mkdir -p ~/.rezzza/php/extensions \
            && pushd . \
            && cd ~/.rezzza/php/extensions \
            && git clone --branch php7 --depth=10 https://github.com/shouze/phpredis \
            && cd phpredis \
            && popd \
            && pickle install --defaults ~/.rezzza/php/extensions/phpredis
    else
        if [ $(php -m | grep -i redis | wc -l) -eq 0 ]; then
            pickle install --defaults redis-2.2.7
        fi
    fi

    phpenv config-add ~/.rezzza.travis-ci/php/conf.d/redis.ini
}

bootstrap_fpm()
{
    cp ~/.rezzza.travis-ci/php/php-fpm.conf ~/.phpenv/versions/$(phpenv version-name)/etc/
    sudo /home/travis/.phpenv/versions/$(phpenv version-name)/sbin/php-fpm
}

usage()
{
cat <<EOF
Bootstrap php on travis ci.

bootsrap.sh [options]

options: any of the following, space separated:
    - apcu
    - fpm
EOF
}

bootstrap_base \
    && bootstrap_pickle \
    && for arg in $* ; do
           printf "Bootstraping: '%s'\n" $arg
           case $arg in
               fpm)
                   bootstrap_fpm
               ;;
               apcu)
                   bootstrap_apcu
               ;;
               redis)
                   bootstrap_redis
               ;;
               *)
                   printf "\nERROR: '%s' option is not implemented yet\n" $arg
                   usage
                   exit -1
               ;;
           esac
       done
exit $?
