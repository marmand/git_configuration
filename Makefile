# This file is under BSD LISCENSE.

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

usage:
	@echo "Usage:"
	@echo "       install    Install the current configuration"

# End of file.
