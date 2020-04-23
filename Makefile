BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: 3rdparty

prepare_offline:
	$(MAKE) -C 3rdparty download
	$(MAKE) -C opt/gitea download
	$(MAKE) -C opt/backup download


.PHONY: 3rdparty
3rdparty:
	$(MAKE) -C 3rdparty all

.PHONY: opt
opt:
	$(MAKE) -C opt/gitea
	$(MAKE) -C opt/backup install

.PHONY: distclean
distclean:
	$(MAKE) -C 3rdparty clean
	$(MAKE) -C opt/backup clean
	$(RM) example/www/css/bootstrap.min.css
	$(RM) example/www/css/bootstrap.min.css.map
	$(RM) -r var/log/*
	$(RM) -r var/exit/*
	$(RM) run/pids/*


.PHONY: example
example: 3rdparty services var/www opt css

services:
	ln -s example/services services

var/www:
	cd var && ln -s ../example/www www

.PHONY: css
css: example/www/css/bootstrap.min.css example/www/css/bootstrap.min.css.map

example/www/css/bootstrap.min.css:
	cat 3rdparty/bootstrap/bootstrap.min.css.gz | gunzip > example/www/css/bootstrap.min.css

example/www/css/bootstrap.min.css.map:
	cat 3rdparty/bootstrap/bootstrap.min.css.map.gz | gunzip > example/www/css/bootstrap.min.css.map
