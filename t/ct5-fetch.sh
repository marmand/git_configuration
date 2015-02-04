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

printf "* 7961e88 J
* 8ac8151 I
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
        test_commit I &&
        test_commit J &&
        git push &&
        git k >result &&
        test_cmp result expect
'

test_done
