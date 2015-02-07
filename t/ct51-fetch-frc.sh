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
        test_do_in author_clone git remote add origin ../remote.git &&
        test_do_in author_clone git fetch --all &&
        test_do_in author_clone git checkout master &&
        test_do_in author_clone test_do_as "Author" test_commit F &&
        test_do_in author_clone test_do_as "Author" git push &&
        git fetch &&
        git k >result &&
        test_cmp result expect
'

test_done
