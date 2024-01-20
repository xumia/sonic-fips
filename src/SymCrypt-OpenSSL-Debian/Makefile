.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

ARCH ?= amd64
CMAKE_BUILD_TYPE ?= Release
BUILD_JOBS ?= $(shell nproc)
BUILD_NAME = symcrypt-openssl
SYMCRYPT_OPENSSL_VERSION ?= 0.1
SYMCRYPT_PACKAGE = $(BUILD_NAME)_$(SYMCRYPT_OPENSSL_VERSION)_$(ARCH).deb
BUILD_ROOT_DIR = tmp/$(BUILD_NAME)

CMAKE_ARCH = AMD64
LIB_INSTALL_NAME = x86_64-linux-gnu
ifeq ($(ARCH), arm64)
CMAKE_ARCH = ARM64
LIB_INSTALL_NAME = aarch64-linux-gnu
else ifeq ($(ARCH), armhf)
CMAKE_ARCH = ARMHF
LIB_INSTALL_NAME = arm-linux-gnueabihf 
endif

INSTALL_PATH = $(BUILD_ROOT_DIR)/usr/lib/$(LIB_INSTALL_NAME)
PROVIDERS_PATH = $(INSTALL_PATH)/ossl-modules
DEBIAN_DIR = $(BUILD_ROOT_DIR)/DEBIAN

ROOT_PATH = $(shell realpath $(shell pwd)/../..)
DEST ?= $(ROOT_PATH)/target
LIBSYMCRYPT = $(DEST)/libsymcrypt.so
LIBSYMCRYPTPROVIDER = $(DEST)/symcryptprovider.so
TARGET = $(DEST)/$(SYMCRYPT_PACKAGE)

DEPENDS := $(LIBSYMCRYPT) $(LIBSYMCRYPTPROVIDER)

all: $(TARGET)

list:
	@$(foreach target,$(DEPENDS) $(TARGET),echo $(target);)

$(LIBSYMCRYPT):
	cd ../SymCrypt
	cmake -S . -B bin -DSYMCRYPT_TARGET_ARCH=$(CMAKE_ARCH) -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
	cmake --build bin -j$(BUILD_JOBS)
	mkdir -p $(DEST)/debug
	cp -a bin/module/generic/libsymcrypt.so* $(DEST)/
	cp -a bin/module/generic/processing/libsymcrypt.so* $(DEST)/debug/

$(LIBSYMCRYPTPROVIDER): $(LIBSYMCRYPT)
	cd ../SymCrypt-OpenSSL
	cp -P $(DEST)/libsymcrypt.so* ./
	mkdir -p bin
	cd bin
	cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake-toolchain/LinuxUserMode-$(CMAKE_ARCH).cmake -DSYMCRYPT_ROOT_DIR=$(ROOT_PATH)/src/SymCrypt -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE)
	cmake --build .
	rm ../libsymcrypt.so*
	cp -a SymCryptProvider/symcryptprovider.so $(LIBSYMCRYPTPROVIDER)

$(LIBSYMCRYPTPROVIDER)-bk:
	wget https://sonicstorage.blob.core.windows.net/public/fips/bookworm/amd64/symcrypt/SymCryptProvider-103.4.0.tar.gz
	mkdir -p SymCryptProvider
	tar -xzf SymCryptProvider-103.4.0.tar.gz -C SymCryptProvider
	cp -a SymCryptProvider/lib/libsymcrypt.so* $(DEST)/
	cp -a SymCryptProvider/symcryptprovider.so $(DEST)/

$(TARGET): $(DEPENDS)
	mkdir -p $(INSTALL_PATH)
	mkdir -p $(PROVIDERS_PATH)
	mkdir -p $(DEBIAN_DIR)
	mkdir -p $(BUILD_ROOT_DIR)/etc/ssl
	cp -a $(DEST)/libsymcrypt.so* $(INSTALL_PATH)/
	cp -a $(LIBSYMCRYPTPROVIDER) $(PROVIDERS_PATH)/
	cp -rf debian/* $(DEBIAN_DIR)/
	chmod a+r -R $(INSTALL_PATH)/
	cp openssl.cnf $(BUILD_ROOT_DIR)/etc/ssl/openssl-fips.cnf
	fakeroot dpkg-deb --build $(BUILD_ROOT_DIR) $(TARGET)
