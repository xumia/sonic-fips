.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS += -e

ROOT_PATH = $(shell realpath $(shell pwd)/../..)
DEST ?= $(ROOT_PATH)/target
MAIN_TARGET = $(DEST)/$(GOLANG)
DERIVED_TARGETS = $(GOLANG)_DERIVED_DEBS

include $(ROOT_PATH)/rules/golang.mk

all: $(MAIN_TARGET)

$(MAIN_TARGET):
	cd ../golang-fips
	cp ../golang/patches/openssl-config.patch patches/999-openssl-config.patch
	scripts/full-initialize-repo.sh $(GOLANGT_TAG)
	cp -r ../golang-debian/debian go/
	cd go
	sed -i "s/$(GOLANG_VERSOIN)/$(GOLANG_VERSOIN)+fips/" debian/changelog
	#cp ../../golang/patches/*.patch debian/patches/
	#comm -23 --nocheck-order ../../golang/patches/series debian/patches/series >> debian/patches/series
	#QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index" QUILT_PATCHES=debian/patches quilt push -a
	#git add src
	#git commit -m "Add patch"
	dpkg-buildpackage -b -d -rfakeroot -us -uc
	cp ../*.deb $(DEST)

$(addprefix $(DEST)/, $(TARGETS)) : $(DEST)/%: $(MAIN_TARGET)

