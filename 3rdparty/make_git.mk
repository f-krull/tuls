modules := $(modules) \
	git

LIBVER_git := 2.26.2

.PHONY: git_download
git_download: download/git-${LIBVER_git}.tar.gz

.PHONY: git_build
git_build: git/bin/git

.PHONY: git_clean
git_clean:
	$(RM) -r git
	$(RM) -r git_build

.PHONY: git_dlclean
git_dlclean:
	$(RM) download/git-${LIBVER_git}.tar.gz

download/git-${LIBVER_git}.tar.gz:
	mkdir -p download/
	cd download && wget https://github.com/git/git/archive/v$(LIBVER_git).tar.gz -O git-2.26.2.tar.gz

git/bin/git: download/git-${LIBVER_git}.tar.gz
	mkdir -p git_build \
		&& cd git_build \
		&& tar xf ../download/git-${LIBVER_git}.tar.gz
	$(MAKE) -C git_build/git-2.26.2 prefix=$(BASEDIR)/git NO_OPENSSL=1 NO_CURL=1 NO_GETTEXT=1 NO_TCLTK=1 -j 5 install
	$(RM) -r git_build
