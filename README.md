travis-ci
=========

Shareable docker bootstrap script for travis-ci:
- Install required docker engine & compose releases:
```yml
env:
    global:
        - DOCKER_VERSION=1.10.3-0~trusty
        - DOCKER_COMPOSE_VERSION=1.6.2
```
- Configure images store path to `~/docker-images` hence you can use travis cache to seedup you builds


## .travis.yml example

```yml
sudo: required
dist: trusty

cache:
    directories:
        - ~/docker-images
        
env:
    global:
        - DOCKER_VERSION=1.10.3-0~trusty
        - DOCKER_COMPOSE_VERSION=1.7.0-rc1
    matrix:
        - TEST=units
        - TEST=functionnal TEST_SUITE=foo
        - TEST=functionnal TEST_SUITE=bar

install:
    - git clone --branch docker-trusty --depth=1 git@github.com:rezzza/travis-ci.git ~/.rezzza-utils
    - ~/.rezzza-utils/bootstrap.sh

before_script:
    ...

script:
    ...
```

