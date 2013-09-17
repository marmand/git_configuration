#########
# Clean #
#########
    cl = !"f () { echo \"Clean.\" && git clean -n -x -d && echo \"Would you like to remove theses files/directories ?\" && read answer && case $answer in y|yes) echo \"Cleaning\"; git clean -f -x -d;; n|no) echo \"Leaving\";; esac; }; f"

