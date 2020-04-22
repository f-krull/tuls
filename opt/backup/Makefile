BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: _all
_add: all

modules := 

include make_rsnapshot.mk

all: $(addsuffix _build, $(modules))

.PHONY: download
download: $(addsuffix _download, $(modules))

.PHONY: clean
clean: $(addsuffix _clean, $(modules))

.PHONY: dlclean
dlclean: $(addsuffix _dlclean, $(modules))

#----

install: all user.conf


user.conf:
	cp user.conf_template user.conf


#----

.PHONY: daily
daily:
	$(BASEDIR)/start_backup.sh $@

.PHONY: weekly
weekly:
	$(BASEDIR)/start_backup.sh $@

.PHONY: monthly
monthly:
	$(BASEDIR)/start_backup.sh $@

