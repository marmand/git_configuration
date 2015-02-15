#########
# Votes #
#########
    pending = !"f() {                                     \
      branches=$(git fetch && git br -a | grep 'votes');  \
      author=$(echo $branches | cut -d '/' -f 4);         \
      branch=$(echo $branches | cut -d '/' -f 5);         \
      echo \"$author wants to merge to $branch\"          \
      ;                                                   \
    }; f"
