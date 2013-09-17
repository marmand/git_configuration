#########
# Alias #
#########
    alias = !"f () { test $# = 2 && git config --global alias.\"$1\" \"$2\" && exit 0 || echo \"usage: git alias <new alias> <original command>\" >&2 && exit 1 - ;}; f"
    aliases = !git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'

