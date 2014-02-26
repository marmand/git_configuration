###############
# Integration #
###############
    integrate = !"f() { echo \"Integrating branch origin/$1 into devel\"; until git co $1; do sleep 1; done; until git fr devel; do sleep 1; done; until git push -f; do sleep 1; done; until git co devel; do sleep 1; done; until git fr $1; do sleep 1; done; until git push; do sleep 1; done; }; f"

