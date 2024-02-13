#!/bin/bash

set -ex

export ARCH=armhf

# Install packages
apt-get update && apt-get install -y sudo
sudo .azure-pipelines/install-packages.sh
git config --global --add safe.directory src/SymCrypt
(cd src/SymCrypt; git submodule update --init -- 3rdparty/jitterentropy-library)
sudo mkdir -p $HOME
sudo pip3 install -r src/SymCrypt/scripts/requirements.txt

# Make SymCrypt and OpenSSL
make symcrypt
make openssl

# Install SymCrypt and OpenSSL
sudo dpkg -i target/libssl*.deb target/openssl*.deb
sudo dpkg -i target/symcrypt-openssl*.deb

# Enable SymCrypt
sudo mkdir -p /etc/fips
echo 1 | sudo tee /etc/fips/fips_enable
openssl engine -v | grep -i symcrypt

# Cleanup OpenSSL source folder
pushd src/openssl
git clean -xdf
git checkout -- .
popd

# Build the OpenSSL again with SymCrypt enabled
TARGET_PATH=target-test make openssl
