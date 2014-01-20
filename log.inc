#######
# Log #
#######
    logs = log --stat
    k = log --graph --oneline
    sl = log --graph --pretty=oneline --abbrev-commit --decorate
    lg = log --graph --pretty=format:'%Cred%h%Creset  %s %C(yellow)%d %Cgreen(%cr, %an)%Creset' --abbrev-commit --date=relative --date-order

