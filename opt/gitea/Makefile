BASEDIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

GITEAVERSION := 1.9.6
GITEABIN     := gitea-$(GITEAVERSION)-linux-amd64

GITEA_BASEDIR = $(BASEDIR)
export GITEA_BASEDIR

all: install
	
.PHONY: install
install: $(GITEABIN) custom/conf/app.ini custom/public custom/templates

custom/conf/app.ini:
	mkdir -p custom/conf/ && envsubst < config.txt > custom/conf/app.ini

custom/templates: 
	cd custom && ln -s ../custom_example/templates

custom/public: 
	cd custom && ln -s ../custom_example/public

.PHONY: run
run: 
	./$(GITEABIN) web 

.PHONY: download
download: $(GITEABIN)

$(GITEABIN):
	wget https://github.com/go-gitea/gitea/releases/download/v$(GITEAVERSION)/$(GITEABIN)
	chmod ogu+x ${GITEABIN}
