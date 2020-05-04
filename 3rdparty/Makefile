BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: _all
_add: all

modules := 

include make_busybox.mk
include make_git.mk
include make_lighttpd.mk

all: $(addsuffix _build, $(modules))

.PHONY: download
download: $(addsuffix _download, $(modules))

.PHONY: clean
clean: $(addsuffix _clean, $(modules))

.PHONY: dlclean
dlclean: $(addsuffix _dlclean, $(modules))
