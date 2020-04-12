BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: 3rdparty

prepare_offline:
	$(MAKE) -C 3rdparty download

.PHONY: 3rdparty
3rdparty:
	$(MAKE) -C 3rdparty all

.PHONY: distclean
distclean:
	$(MAKE) -C 3rdparty clean


.PHONY: example
example: services var/www
	bin/update

services:
	ln -s example/services services

var/www:
	cd var && ln -s ../example/www www
