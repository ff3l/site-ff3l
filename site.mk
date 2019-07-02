GLUON_MULTIDOMAIN=1
GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-source-filter \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	radvd \
	respondd \
	status-page \
	web-advanced \
	web-logging \
	web-private-wifi \
	web-wizard

GLUON_SITE_PACKAGES := \
gluon-config-mode-domain-select \
gluon-config-mode-geo-location-osm \
gluon-radv-filterd \
haveged \
iwinfo \
-gluon-web-mesh-vpn-fastd \
respondd-module-airtime \
gluon-ssid-changer \
gluon-segment-mover \
gluon-config-mode-segment-mover \
addrefkey

GLUON_DEPRECATED ?= upgrade

GLUON_REGION ?= eu

GLUON_ATH10K_MESH ?= 11s

DEFAULT_GLUON_RELEASE := g$(shell git -C $(shell pwd) log --pretty=format:'%h' -n 1)+s$(shell git -C $(shell pwd)/site log --pretty=format:'%h' -n 1)~$(shell date '+%Y%m%d')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0

GLUON_LANGS ?= en de fr

############################
# Additional package sets
#############################

# USB Human Interface
USB_PKGS_HID := \
	kmod-usb-hid \
	kmod-hid-generic

# USB Serial
USB_PKGS_SERIAL := \
	kmod-usb-serial \
	kmod-usb-serial-ftdi \
	kmod-usb-serial-pl2303

NO_USB_PKGS_SERIAL := \
	-kmod-usb-serial \
	-kmod-usb-serial-ftdi \
	-kmod-usb-serial-pl2303

# USB Storage
USB_PKGS_STORAGE := \
	block-mount \
	blkid \
	kmod-fs-ext4 \
	kmod-fs-ntfs \
	kmod-fs-vfat \
	kmod-usb-storage \
	kmod-usb-storage-extras \
	kmod-nls-base \
	kmod-nls-cp1250 \
	kmod-nls-cp1251 \
	kmod-nls-cp437 \
	kmod-nls-cp850 \
	kmod-nls-cp852 \
	kmod-nls-iso8859-1 \
	kmod-nls-iso8859-13 \
	kmod-nls-iso8859-15 \
	kmod-nls-iso8859-2 \
	kmod-nls-utf8 \
	swap-utils

NO_USB_PKGS_STORAGE := \
	-block-mount \
	-blkid \
	-kmod-fs-ext4 \
	-kmod-fs-ntfs \
	-kmod-fs-vfat \
	-kmod-usb-storage \
	-kmod-usb-storage-extras \
	-kmod-nls-base \
	-kmod-nls-cp1250 \
	-kmod-nls-cp1251 \
	-kmod-nls-cp437 \
	-kmod-nls-cp850 \
	-kmod-nls-cp852 \
	-kmod-nls-iso8859-1 \
	-kmod-nls-iso8859-13 \
	-kmod-nls-iso8859-15 \
	-kmod-nls-iso8859-2 \
	-kmod-nls-utf8 \
	-swap-utils

# USB Wired Ethernet Network
USB_PKGS_NET := \
	kmod-mii \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-asix-ax88179 \
	kmod-usb-net-cdc-eem \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-cdc-subset \
	kmod-usb-net-dm9601-ether \
	kmod-usb-net-hso \
	kmod-usb-net-mcs7830 \
	kmod-usb-net-pegasus \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-smsc95xx

NO_USB_PKGS_NET := \
	-kmod-mii \
	-kmod-usb-net \
	-kmod-usb-net-asix \
	-kmod-usb-net-asix-ax88179 \
	-kmod-usb-net-cdc-eem \
	-kmod-usb-net-cdc-ether \
	-kmod-usb-net-cdc-subset \
	-kmod-usb-net-dm9601-ether \
	-kmod-usb-net-hso \
	-kmod-usb-net-mcs7830 \
	-kmod-usb-net-pegasus \
	-kmod-usb-net-rtl8152 \
	-kmod-usb-net-smsc95xx

# PCI-Express Network
PCIE_PACKAGES_NET := \
	kmod-bnx2 \
	kmod-ath \
	kmod-ath9k \
	kmod-ath9k-common \
	kmod-mac80211

# Group previous package sets
USB_PKGS_WITHOUT_HID := \
	usbutils \
	$(USB_PKGS_SERIAL) \
	$(USB_PKGS_STORAGE) \
	$(USB_PKGS_NET)

NO_USB_PKGS_WITHOUT_HID := \
	-usbutils \
	$(NO_USB_PKGS_SERIAL) \
	$(NO_USB_PKGS_STORAGE) \
	$(NO_USB_PKGS_NET)

USB_PKGS := \
	$(USB_PKGS_HID) \
	$(USB_PKGS_WITHOUT_HID)

PCIE_PKGS := \
	pciutils \
	$(PCIE_PACKAGES_NET)


##################################
# Assign package sets to targets
##################################

# Embedded Routers
ifeq ($(GLUON_TARGET),ar71xx-generic)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)

	# lowmem or no usb port
	GLUON_alfa-network-ap121_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_alfa-network-ap121u_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_alfa-network-hornet-ub_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_alfa-network-n2-n5_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_alfa-network-tube2h_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_d-link-dir-615-h1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_d-link-dir-615-rev-c1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-tl-wr842n-nd-v1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-tl-wr842n-nd-v2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-tl-wr1043n-nd-v1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-wbs210-v1.20_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-wbs510-v1.20_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-cpe210-v1.0_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-cpe210-v1.1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-cpe220-v1.1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-cpe510-v1.0_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-cpe510-v1.1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-cpe520-v1.1_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_tp-link-re450_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_linksys-wrt160nl_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_meraki-mr12_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_meraki-mr16_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_meraki-mr62_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_meraki-mr66_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_netgear-wnr2200_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-mr1750_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-mr1750v2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-mr600_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-mr600v2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-mr900_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-mr900v2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om2p-hs_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om2p-hsv2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om2p-hsv3_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om2p-lc_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om2p_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om2pv2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om5p-ac_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om5p-acv2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om5p-an_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_openmesh-om5p_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-airgateway-lr_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-airgateway-pro_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-airgateway_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-airrouter_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-bullet-m2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-bullet-m5_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-bullet-m_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-loco-m-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-ls-sr71_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-loco-m2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-loco-m2-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-loco-m5_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-loco-m5-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-m2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-m2-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-m5_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-m5-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-m_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-nanostation-m-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-picostation-m2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m2_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m2-ti_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m2-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m5_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m5-ti_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m5-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m-ti_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-rocket-m-xw_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi-ac-lite_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi-ac-mesh_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi-ac-pro_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi-ap-lr_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifiap-outdoor_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifiap-outdoor+_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi-ap-pro_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi-ap_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
	GLUON_ubiquiti-unifi_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ar71xx-nand)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ipq806x)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ramips-mt7620)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ramips-mt7621)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)

	# no usb port
	GLUON_ubnt-erx_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)

	# lowmem
	GLUON_vocore-8M_SITE_PACKAGES += $(NO_USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ramips-mt7628)
	GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

# x86 Generic Purpose Hardware
ifeq ($(GLUON_TARGET),x86-generic)
	GLUON_SITE_PACKAGES += $(USB_PKGS) $(PCIE_PKGS)
endif

ifeq ($(GLUON_TARGET),x86-64)
	GLUON_SITE_PACKAGES += $(USB_PKGS) $(PCIE_PKGS)
endif

# PCEngines ALIX Boards
ifeq ($(GLUON_TARGET),x86-geode)
	GLUON_SITE_PACKAGES += $(USB_PKGS) $(PCIE_PKGS)
endif

#  Raspberry Pi A/B/B+
ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
	GLUON_SITE_PACKAGES += $(USB_PKGS)
endif

# Raspberry Pi 2
ifeq ($(GLUON_TARGET),brcm2708-bcm2709)
	GLUON_SITE_PACKAGES += $(USB_PKGS)
endif

# Raspberry Pi 3
ifeq ($(GLUON_TARGET),brcm2708-bcm2710)
	GLUON_SITE_PACKAGES += $(USB_PKGS)
endif

# Banana Pi/Pro, Lamobo R1
ifeq ($(GLUON_TARGET),sunxi)
	GLUON_SITE_PACKAGES += $(USB_PKGS)
endif