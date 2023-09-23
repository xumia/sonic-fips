# openssl

OPENSSL_VERSION = 3.1.2-1
OPENSSL_VERSION_FIPS = $(OPENSSL_VERSION)+fips
OPENSSL = openssl_$(OPENSSL_VERSION_FIPS)_$(ARCH).deb
$(OPENSSL)_SRC_PATH = $(SRC_PATH)/openssl

MAIN_TARGETS += $(OPENSSL)
$(OPENSSL)_DERIVED_DEBS = libssl3_$(OPENSSL_VERSION_FIPS)_$(ARCH).deb
$(OPENSSL)_DERIVED_DEBS += libssl-dev_$(OPENSSL_VERSION_FIPS)_$(ARCH).deb
$(OPENSSL)_DERIVED_DEBS += openssl-dbgsym_$(OPENSSL_VERSION_FIPS)_$(ARCH).deb
$(OPENSSL)_DERIVED_DEBS += libssl3-dbgsym_$(OPENSSL_VERSION_FIPS)_$(ARCH).deb
$(OPENSSL)_DERIVED_DEBS += libssl-doc_$(OPENSSL_VERSION_FIPS)_all.deb
