BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TULS_BASEDIR ?= $(BASEDIR)/../../
DOCROOT ?= $(BASEDIR)/www/

include  config_default.txt
-include config.txt


PHONY: prepare_offline
prepare_offline:
	make -C 3rdparty download

all: | prepare_offline 3rdparty

.PHONY: 3rdparty
3rdparty:
	make -C 3rdparty

.PHONY: distclean
distclean:
	$(MAKE) -C 3rdparty clean

.PHONY: dlclean
dlclean:
	$(RM) -r 3rdparty/download


${DBDATADIR}/postgresql.conf: 3rdparty
	bash bin/dbinit.sh

.PHONY: 
dbstart: ${DBDATADIR}/postgresql.conf
	3rdparty/postgresql/bin/pg_isready -h localhost -p $(DBPORT) -d $(DBNAME) || 3rdparty/postgresql/bin/pg_ctl -D ${DBDATA_DIR} -l ${DBLOG_FILE} -w start && echo ok

.PHONY: 
dbstop:
	3rdparty/postgresql/bin/pg_ctl -D ${DBDATADIR} stop

.PHONY: 
dberase:
	3rdparty/postgresql/bin/pg_ctl -D ${DBDATADIR} stop || true
	$(RM) -r ${DBDATADIR}

.PHONY: run_webui
run_webui: 3rdparty
	PORT=$(PORT)  DOCROOT=$(DOCROOT) TULS_BASEDIR=$(TULS_BASEDIR) LLPP_BASEDIR=$(BASEDIR) 3rdparty/lighttpd/sbin/lighttpd -D -f lighttpd.conf

.PHONY: run_db
run_db: ${DBDATADIR}/postgresql.conf
	3rdparty/postgresql/bin/pg_isready -h localhost -p $(DBPORT) -d $(DBNAME) && $(MAKE) dbstop || true
	3rdparty/postgresql/bin/postgres -D $(DBDATADIR) -h 0.0.0.0 -p $(DBPORT)
