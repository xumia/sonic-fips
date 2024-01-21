# openssh

OPENSSH_VERSION = 9.2p1-2+deb12u2
OPENSSH_VERSION_FIPS = $(OPENSSH_VERSION)+fips
OPENSSH_SERVER = openssh-server_$(OPENSSH_VERSION_FIPS)_$(ARCH).deb
$(OPENSSH_SERVER)_SRC_PATH = $(SRC_PATH)/openssh
$(OPENSSH_SERVER)_DEPENDS = $(SYMCRYPT_OPENSSL)
$(OPENSSH_SERVER)_BUILD_OPTIONS=LIBS="-lsymcryptengine -lsymcrypt -lcrypto -lssl -ledit" DEB_BUILD_PROFILES="noudeb" DEB_BUILD_OPTIONS="nocheck nostrip"  DEB_CFLAGS_APPEND="-DUSE_SYMCRYPT_ENGINE"
$(OPENSSH_SERVER)_PRE_SCRIPT = sudo dpkg -i $(TARGET_PATH)/$(SYMCRYPT_OPENSSL);

MAIN_TARGETS += $(OPENSSH_SERVER)
$(OPENSSH_SERVER)_DERIVED_DEBS = ssh_$(OPENSSH_VERSION_FIPS)_all.deb
$(OPENSSH_SERVER)_DERIVED_DEBS += openssh-client_$(OPENSSH_VERSION_FIPS)_$(ARCH).deb
$(OPENSSH_SERVER)_DERIVED_DEBS += openssh-sftp-server_$(OPENSSH_VERSION_FIPS)_$(ARCH).deb
$(OPENSSH_SERVER)_DERIVED_DEBS += ssh-askpass-gnome_$(OPENSSH_VERSION_FIPS)_$(ARCH).deb
