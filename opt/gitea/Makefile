BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

GITEAVERSION := 1.14.1
GITEABIN     := gitea-$(GITEAVERSION)-linux-amd64

GITEA_BASEDIR = $(BASEDIR)
export GITEA_BASEDIR

all: install
	
.PHONY: install
install: $(GITEABIN) custom custom/conf/app.ini

custom/conf/app.ini: custom
	mkdir -p custom/conf/ && envsubst < config.txt > custom/conf/app.ini

.PHONY: run
run: 
	./$(GITEABIN) web 

.PHONY: download
download: $(GITEABIN)

$(GITEABIN):
	wget https://github.com/go-gitea/gitea/releases/download/v$(GITEAVERSION)/$(GITEABIN)
	chmod ogu+x ${GITEABIN}
