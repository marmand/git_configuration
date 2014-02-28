# This file is under BSD LISCENSE.

include t/Makefile.vars

all: usage

install:
	cat template.gitconfig > ~/.gitconfig
	cat *.inc >> ~/.gitconfig
	echo "We will now proceed with git configuration."; 	\
	    echo "Please, enter your name."; 			\
	    read name; 						\
	    echo "Please enter your email address."; 		\
	    read email; 					\
	    echo "Please enter your favorite editor."; 		\
	    read edt; 						\
	    echo "Please enter your favorite merge tool."; 	\
	    read mrg; 						\
	    sed -ie "s/@NAME@/$$name/" ~/.gitconfig; 		\
	    sed -ie "s/@EMAIL@/$$email/" ~/.gitconfig; 		\
	    sed -ie "s/@MERGETOOL@/$$mrg/" ~/.gitconfig; 	\
	    sed -ie "s/@EDITOR@/$$edt/" ~/.gitconfig; 		\
	    sed -ie "s#@HOME@#$$HOME#" ~/.gitconfig;

test: check
check: $(CT)

prepare-check: git-repo/Makefile
	cd git-repo/t; git checkout Makefile
	$(MAKE) -C git-repo
	cat t/Makefile.vars >> git-repo/t/Makefile
	cat t/Makefile >> git-repo/t/Makefile
	touch prepare-check

$(CT): prepare-check
	rsync t/$@ git-repo/t/$@
	$(MAKE) -C git-repo/t $@

git-repo/Makefile:
	git submodule init
	git submodule update

clean:
	cd git-repo; git clean -f -x -d
	cd git-repo; git checkout t/Makefile

usage:
	@echo "Targets:"
	@echo "       install    Install the current configuration"
	@echo "       test       Test the current configuration"
	@echo "       check      Test the current configuration"

.PHONY: test check $(CT)

# End of file.
