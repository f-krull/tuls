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


.PHONY: example
example: services var/www opt css
	bin/update

services:
	ln -s example/services services

var/www:
	cd var && ln -s ../example/www www

.PHONY: css
css: example/www/css/bootstrap.min.css

example/www/css/bootstrap.min.css:
	cat 3rdparty/bootstrap/bootstrap.min.css.gz | gunzip > example/www/css/bootstrap.min.css

example/www/css/bootstrap.min.map.css:
	cat 3rdparty/bootstrap/bootstrap.min.css.map.gz | gunzip > example/www/css/bootstrap.min.map.css
