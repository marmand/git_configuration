#! /bin/sh

test_description='Checking branch aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup branch aliases' '
        configurate_with commits log checkout branch fetch votes
'

printf "* 0ddfaf1 A
" >expect
test_expect_success 'Setup repository' '
        git init --bare remote.git &&
        git remote add origin remote.git &&
        test_commit A &&
        git push -u origin master &&
        test_do_in author_clone test_do_as "Author" git remote add origin ../remote.git &&
        test_do_in author_clone test_do_as "Author" git fetch --all &&
        test_do_in author_clone test_do_as "Author" git checkout master &&
        test_do_in author_clone test_do_as "Author" test_commit B &&
        test_do_in author_clone test_do_as "Author" test_commit C &&
        test_do_in author_clone test_do_as "Author" test_commit D &&
        test_do_in author_clone test_do_as "Author" test_commit E &&
        test_do_in author_clone test_do_as "Author" git push &&
        test_do_in author_clone test_do_as "Author" git push origin HEAD:votes/author/master &&
        git fetch &&
        git k >result &&
        test_cmp result expect
'

test_done
