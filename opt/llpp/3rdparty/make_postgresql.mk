modules := $(modules) \
	postgresql

PSQLVER := 10.9

.PHONY: postgresql_download
postgresql_download: download/postgresql-${PSQLVER}.tar.gz

.PHONY: postgresql_build
postgresql_build: postgresql/bin/postgres

.PHONY: postgresql_clean
postgresql_clean:
	$(RM) -r postgresql
	$(RM) -r postgresql_build

download/postgresql-${PSQLVER}.tar.gz:
	mkdir -p download/
	cd download && wget http://ftp.postgresql.org/pub/source/v${PSQLVER}/postgresql-${PSQLVER}.tar.gz

postgresql/bin/postgres: download/postgresql-${PSQLVER}.tar.gz
	mkdir -p postgresql_build \
		&& cd postgresql_build \
		&& tar xf ../download/postgresql-${PSQLVER}.tar.gz \
		&& cd postgresql-$(PSQLVER) \
		&& ./configure --prefix=$(BASEDIR)/postgresql --without-readline
	$(MAKE) -C postgresql_build/postgresql-$(PSQLVER)
	$(MAKE) -C postgresql_build/postgresql-$(PSQLVER) install
	$(RM) -r postgresql_build
