BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

GITEAVERSION := 1.9.6
GITEABIN     := gitea-$(GITEAVERSION)-linux-amd64

GITEA_BASEDIR = $(BASEDIR)
export GITEA_BASEDIR

all: $(GITEABIN)
	[ -f config.txt ] && [ ! -f custom/conf/app.ini ] \
	  && mkdir -p custom/conf/ \
		&& envsubst < config.txt > custom/conf/app.ini || true
	./$(GITEABIN) web 

.PHONY: prepare_offline
prepare_offline: $(GITEABIN)


$(GITEABIN):
	wget https://github.com/go-gitea/gitea/releases/download/v$(GITEAVERSION)/$(GITEABIN)
	chmod ogu+x ${GITEABIN}
