#!/bin/sh
echo "127.0.0.1 $*" | sudo tee -a /etc/hosts
