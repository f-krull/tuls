modules := $(modules) \
	busybox

LIBVER_busybox := 1.33.0

.PHONY: busybox_download
busybox_download: download/busybox-${LIBVER_busybox}.tar.bz2

.PHONY: busybox_build
busybox_build: busybox/bin/busybox

.PHONY: busybox_clean
busybox_clean:
	$(RM) -r busybox
	$(RM) -r busybox_build

.PHONY: busybox_dlclean
busybox_dlclean:
	$(RM) download/busybox-${LIBVER_busybox}.tar.bz2

download/busybox-${LIBVER_busybox}.tar.bz2:
	mkdir -p download/
	cd download && wget https://www.busybox.net/downloads/busybox-${LIBVER_busybox}.tar.bz2

busybox/bin/busybox: download/busybox-${LIBVER_busybox}.tar.bz2
	mkdir -p busybox_build \
		&& cd busybox_build \
		&& tar xf ../download/busybox-${LIBVER_busybox}.tar.bz2
	$(MAKE) -C busybox_build/busybox-$(LIBVER_busybox) defconfig
	# begin fixes for Centos6 - not needed for Centos7
	sed -i "s/CONFIG_SYNC=.*/# CONFIG_SYNC is not set/" busybox_build/busybox-$(LIBVER_busybox)/.config
	sed -i "s/CONFIG_FEATURE_SYNC_FANCY=.*/# CONFIG_FEATURE_SYNC_FANCY is not set/" busybox_build/busybox-$(LIBVER_busybox)/.config
	sed -i "s/CONFIG_TOUCH=/# CONFIG_TOUCH is not set/" busybox_build/busybox-$(LIBVER_busybox)/.config
	sed -i "s/CONFIG_FEATURE_TOUCH_NODEREF=.*/# CONFIG_FEATURE_TOUCH_NODEREF is not set/" busybox_build/busybox-$(LIBVER_busybox)/.config
	sed -i "s/CONFIG_FEATURE_TOUCH_SUSV3=.*/# CONFIG_FEATURE_TOUCH_SUSV3 is not set/" busybox_build/busybox-$(LIBVER_busybox)/.config
	sed -i "s/CONFIG_NSENTER=.*/# CONFIG_NSENTER is not set/" busybox_build/busybox-$(LIBVER_busybox)/.config
	# end fixes for Centos6
	# TSD might not have static libs install; But if possbitble append LDFLAGS="--static" below
	$(MAKE) -C busybox_build/busybox-$(LIBVER_busybox) install CONFIG_PREFIX=$(BASEDIR)/busybox
	$(RM) -r busybox_build
