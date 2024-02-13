#!/bin/bash

set -x
sudo mkdir -p $HOME
sudo chown $USER $HOME
sudo apt-get update
sudo apt-get install -y git python3-pip
sudo apt-get install -y cmake git make build-essential quilt debhelper bc python3 python3-pip sudo libssl-dev libgcc-10-dev
sudo apt-get install -y clang
sudo apt-get install -y openssl libssl-dev libssl1.1
sudo apt-get install -y dh-exec dh-runit libaudit-dev libedit-dev libfido2-dev libgtk-3-dev libkrb5-dev
sudo apt-get install -y libwrap-dev pkg-config
sudo apt-get install -y libpam-dev libselinux1-dev libsystemd-dev libwrap0-dev
