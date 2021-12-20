#!/bin/bash

sudo mkdir -p $HOME
sudo chown $USER $HOME
sudo apt-get update
sudo apt-get install -y cmake git make build-essential quilt debhelper bc python3 python3-pip sudo libssl-dev libgcc-10-dev
sudo apt-get install -y clang
sudo apt-get install -y openssl libssl-dev libssl1.1
sudo apt-get install -y dh-exec dh-runit libaudit-dev libedit-dev libfido2-dev libgtk-3-dev libkrb5-dev
sudo apt-get install -y libwrap-dev pkg-config
sudo apt-get install -y libpam-dev libselinux1-dev libsystemd-dev libwrap0-dev

# Build Golang
sudo apt-get install -y golang

# Build Python
sudo apt-get install -y lsb-release sharutils libreadline-dev libncursesw5-dev  libbz2-dev liblzma-dev libgdbm-dev libdb-dev tk-dev blt-dev  libexpat1-dev libmpdec-dev libbluetooth-dev locales-all libsqlite3-dev media-types
sudo apt-get install -y time net-tools xvfb systemtap-sdt-dev python3-sphinx python3-docs-theme texinfo
sudo pip3 install blurb

sudo pip3 install -r src/SymCrypt/scripts/requirements.txt

cd src/SymCrypt
git submodule update --init -- jitterentropy-library
