#!/bin/sh
echo "yes\nno\n" | pecl -d preferred_state=stable install apcu-4.0.10 && phpenv config-add ~/.rezzza.travis-ci/php/conf.d/apcu.ini && phpenv config-add ~/.rezzza.travis-ci/php/conf.d/opcode.ini
