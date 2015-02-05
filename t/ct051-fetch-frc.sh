#! /bin/sh

test_description='Checking branch aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup branch aliases' '
        configurate_with commits log checkout branch fetch
'

printf '* 23f8942 E
* 4013395 D
* 35a8500 C
* d9df450 B
* 0ddfaf1 A
' >expect
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
        git nbr toto &&
        test_commit G &&
        test_commit H &&
        test_commit I &&
        git push &&
        test_do_in author_clone test_do_as "Author" git pull &&
        test_do_in author_clone test_do_as "Author" git checkout toto &&
        test_do_in author_clone test_do_as "Author" test_commit J &&
        test_do_in author_clone test_do_as "Author" test_commit K &&
        test_do_in author_clone test_do_as "Author" test_commit L &&
        test_do_in author_clone test_do_as "Author" test_commit M &&
        test_do_in author_clone test_do_as "Author" test_commit N &&
        test_do_in author_clone test_do_as "Author" test_commit O &&
        test_do_in author_clone test_do_as "Author" git push &&
        git fetch &&
        test_cmp result expect
'

printf "* b100e5c I
* e351f26 H
* c1ebd3d G
* 23f8942 E
* 4013395 D
* 35a8500 C
* d9df450 B
* 0ddfaf1 A
" >expect
test_expect_success 'Check current repository status'  '
        git k >result &&
        test_cmp result expect
'

printf "* 5c6b5f1 O
* de89121 N
* c7f9fab M
* 987d817 L
* b565aec K
* 0e4bc46 J
* b100e5c I
* e351f26 H
* c1ebd3d G
* 23f8942 E
* 4013395 D
* 35a8500 C
* d9df450 B
* 0ddfaf1 A
" >expect
test_expect_success 'Check fetch rebased current repository status'  '
        git frc &&
        git k >result &&
        test_cmp result expect
'

test_done
