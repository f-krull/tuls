modules := $(modules) \
	rsnapshot

RSSVERSION := 1.4.3
RSNAME     := rsnapshot-$(RSSVERSION)

.PHONY: rsnapshot_download
rsnapshot_download: download/${RSNAME}.tar.gz

.PHONY: rsnapshot_build
rsnapshot_build: rsnapshot/bin/rsnapshot

.PHONY: rsnapshot_clean
rsnapshot_clean:
	$(RM) -r rsnapshot
	$(RM) -r rsnapshot_build

.PHONY: rsnapshot_dlclean
rsnapshot_dlclean:
	$(RM) download/${RSNAME}.tar.gz

download/${RSNAME}.tar.gz:
	mkdir -p download/
	cd download && wget https://rsnapshot.org/downloads/$(RSNAME).tar.gz

rsnapshot/bin/rsnapshot: download/${RSNAME}.tar.gz
	mkdir -p rsnapshot_build \
		&& cd rsnapshot_build \
		&& tar xf ../download/${RSNAME}.tar.gz \
		&& cd $(RSNAME) \
		&& ./configure --prefix=$(BASEDIR)/rsnapshot
	$(MAKE) -C rsnapshot_build/$(RSNAME)
	$(MAKE) -C rsnapshot_build/$(RSNAME) install
	$(RM) -r rsnapshot_build
