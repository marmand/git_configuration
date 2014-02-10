###############
# Integration #
###############
    integrate = !"f() { echo \"Integrating branch origin/$1 into devel\"; git co $1; git fr devel; git push -f; git co devel; git fr $1; git push; }; f"

