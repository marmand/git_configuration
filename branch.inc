##########
# Branch #
##########
    br = branch
    bra = branch -a
    # Current branch
    cbr = !"f() { git branch --no-color | sed -ne '/^\\* */s///p'; }; f"
    # New Branch
    nbr = !"f() { test ! "x$1x" = xx && git br $1 && git push origin $1 && git br -d $1 && git cob $1; }; f"
    # Delete branch
    dbr = !"f() { test ! "x$1x" = xx && echo \"Deleting $1\" && git push origin :refs/heads/$1 && git br -D $1; }; f"
    db = !"f() { test ! "x$1x" = xx && echo \"Deleting local $1\" && git br -D $1; }; f"

