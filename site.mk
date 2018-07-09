GLUON_SITE_PACKAGES := \
gluon-mesh-batman-adv-15 \
gluon-respondd \
respondd-module-airtime \
gluon-autoupdater \
gluon-config-mode-autoupdater \
gluon-config-mode-contact-info \
gluon-config-mode-core \
gluon-config-mode-geo-location \
gluon-config-mode-hostname \
gluon-config-mode-mesh-vpn \
gluon-ebtables-filter-multicast \
gluon-ebtables-filter-ra-dhcp \
gluon-ebtables-segment-mld \
gluon-ebtables-source-filter \
gluon-web-admin \
gluon-web-autoupdater \
gluon-web-network \
gluon-web-private-wifi \
gluon-web-wifi-config \
gluon-mesh-vpn-fastd \
gluon-radvd \
gluon-setup-mode \
gluon-status-page \
haveged \
iptables \
iwinfo \
ipv6-to-stable \
site2domain

ifeq ($(GLUON_TARGET),x86-generic)
	GLUON_SITE_PACKAGES := $(GLUON_SITE_PACKAGES) \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-ath \
	kmod-ath9k \
	kmod-ath9k-common \
	kmod-mac80211
endif
ifeq ($(GLUON_TARGET),x86-64)
	GLUON_SITE_PACKAGES := $(GLUON_SITE_PACKAGES) \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-ath \
	kmod-ath9k \
	kmod-ath9k-common \
	kmod-mac80211
endif

GLUON_REGION ?= eu

GLUON_ATH10K_MESH ?= 11s

DEFAULT_GLUON_RELEASE := g$(shell git -C $(shell pwd) log --pretty=format:'%h' -n 1)+s$(shell git -C $(shell pwd)/site log --pretty=format:'%h' -n 1)~$(shell date '+%Y%m%d')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_LANGS ?= en de fr
