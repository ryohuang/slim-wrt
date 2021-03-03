#
# Copyright (C) 2021 OpenWrt-dist
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=slim-localization
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=ryohuang <anyisdad@icloud.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/slim-localization
	SECTION:=luci
	CATEGORY:=Slim
	TITLE:=Slim localization configuration
	PKGARCH:=all
	DEPENDS:=+luci \
			 +luci-i18n-base-zh-cn \
			 +luci-i18n-firewall-zh-cn \
			 +luci-i18n-upnp-zh-cn \
			 +luci-i18n-ttyd-zh-cn
endef

define Package/slim-localization/description
	slim localization configuration
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/slim-localization/postinst
endef

define Package/slim-localization/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/root/etc/uci-defaults/slim-localization $(1)/etc/uci-defaults/slim-localization
endef


$(eval $(call BuildPackage,slim-localization))
