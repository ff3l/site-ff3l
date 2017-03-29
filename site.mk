GLUON_SITE_PACKAGES := \
gluon-mesh-batman-adv-15 \
gluon-respondd \
gluon-autoupdater \
gluon-config-mode-autoupdater \
gluon-config-mode-contact-info \
gluon-config-mode-core \
gluon-config-mode-geo-location \
gluon-config-mode-hostname \
gluon-config-mode-mesh-vpn \
gluon-ebtables-filter-multicast \
gluon-ebtables-filter-ra-dhcp \
gluon-web-admin \
gluon-web-autoupdater \
gluon-web-network \
gluon-web-private-wifi \
gluon-web-wifi-config \
gluon-neighbour-info \
gluon-mesh-vpn-fastd \
gluon-radvd \
gluon-setup-mode \
gluon-status-page \
haveged \
iptables \
iwinfo \
gluon-radv-filterd \
tecff-ath9k-broken-wifi-workaround \
ffmwu-beta-to-testing

ifeq ($(GLUON_TARGET),x86-generic)
	GLUON_SITE_PACKAGES := $(GLUON_SITE_PACKAGES) \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-acpi-button
endif
ifeq ($(GLUON_TARGET),x86-64)
	GLUON_SITE_PACKAGES := $(GLUON_SITE_PACKAGES) \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-acpi-button
endif

GLUON_REGION ?= eu

GLUON_ATH10K_MESH ?= 11s

DEFAULT_GLUON_RELEASE := gluon-$(shell git -C $(GLUONDIR) log --pretty=format:'%h' -n 1)+site-$(shell git -C $(GLUONDIR)/site log --pretty=format:'%h' -n 1)~$(shell date '+%Y%m%d')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_LANGS ?= en de fr
