#!/bin/sh
ARCH=""
if [ $(arch | grep -c x86_64) == 1 ] ; then
    ARCH="-amd64"
fi

mkdir -p ~/.downloads/princexml \
    && cd ~/.downloads/princexml \
    && curl http://www.princexml.com/download/prince-8.1r5-linux$ARCH-static.tar.gz -o - | tar -xvzpf - \
    && cd prince-8.1r5-linux$ARCH-static \
    && ./install.sh
