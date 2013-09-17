##########
#  Fetch #
# Rebase #
##########
    # Fetch/rebase
    fr = !"f() { test ! "x$1x" = xx && echo \"Fetch/rebase on origin/$1\" && git fetch && git rebase origin/$1; }; f"
    # Fetch/rebase on current branch
    frc = !"f() { mybranch=$(git cbr); git fr \"$mybranch\"; }; f"
    # Rebase on master
    frm = !"f() { git fr \"master\"; }; f"
    # Rebase on current branch
    rc = !"f() { mybranch=$(git cbr); git rebase \"origin/$mybranch\"; }; f"

