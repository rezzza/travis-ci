travis-ci
=========

Shareable docker bootstrap script for travis-ci:
- Install required docker engine & compose releases:
```
env:
    global:
        - DOCKER_VERSION=1.10.3-0~trusty
        - DOCKER_COMPOSE_VERSION=1.6.2
```
- Configure images store path to `/var/lib/docker-images` hence you can use travis cache to seedup you builds
