#! /bin/sh

test_description='Checking branch aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup branch aliases' '
        configurate_with commits log checkout branch fetch
'

test_expect_success 'Setup remote repository' '
        git init --bare remote.git &&
        git remote add origin remote.git &&
        test_commit A &&
        test_commit B &&
        test_commit C &&
        test_do_as "Auth Thor" test_commit D &&
        test_commit E &&
        git push -u origin master &&
        git k >result &&
        test_cmp result expect
'

test_done
