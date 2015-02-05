#! /bin/sh

test_description='Checking aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup fetch aliases' '
        configurate_with commits log checkout branch fetch
'

# Setting the following branch tree:
#
# A - B - C - F <- master
#          \
#           D - E - G <- toto
#            \
#             H - I - J <- tata

printf "* 09c5f03 J
* d8b7b55 I
* 13e2fb8 H
* be8f64f D
* 35a8500 C
* d9df450 B
* 0ddfaf1 A
" >expect
test_expect_success 'Setup repository' '
        git init --bare remote.git &&
        git remote add origin remote.git &&
        test_commit A &&
        git push -u origin master &&
        test_commit B &&
        test_commit C &&
        git nbr toto &&
        test_commit D &&
        git nbr tata &&
        git co toto &&
        test_commit E &&
        git co master &&
        test_commit F &&
        git push &&
        git co toto &&
        test_commit G &&
        git push &&
        git co tata &&
        test_commit H &&
        test_commit I &&
        test_commit J &&
        git push &&
        git k >result &&
        test_cmp result expect
'

printf "* 9653d82 J
* 30183ad I
* 2116688 H
* 1870fa1 D
* f231f7a F
* 35a8500 C
* d9df450 B
* 0ddfaf1 A
" >expect
test_expect_success 'Fetch rebase tata on master' '
        git co master &&
        git co tata &&
        git fr master &&
        git push -f &&
        git k >result &&
        test_cmp result expect
'

# A - B - C - F <- master
#          \   \
#           \   D - H - I - J <- tata
#            \
#             D - E - G <- toto

printf "* 603ce00 G
* b48c3a3 E
* 9653d82 J
* 30183ad I
* 2116688 H
* 1870fa1 D
* f231f7a F
* 35a8500 C
* d9df450 B
* 0ddfaf1 A
" >expect
test_expect_success 'Fetch rebase toto on tata' '
        git co toto &&
        git fr tata &&
        git push -f &&
        git k >result &&
        test_cmp result expect
'

# A - B - C - F <- master
#              \
#               D - H - I - J <- tata
#                            \
#                             E - G <- toto

test_done
