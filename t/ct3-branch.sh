#! /bin/sh

test_description='Checking branch aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup branch aliases' '
        configurate_with checkout branch
'

printf "" >expect
test_expect_success 'List branch with nothing' '
        git br >result &&
        test_cmp result expect
'

printf "* master\n" >expect
test_expect_success 'List branch with simple commit' '
        echo "first" >first &&
        git add first &&
        git commit -m "first" &&
        git br >result &&
        test_cmp result expect
'

printf "* devel\n  master\n" >expect
test_expect_success 'List branch with simple commit' '
        git checkout -b devel &&
        echo "second" >second &&
        git add second &&
        git commit -m "second" &&
        git br >result &&
        test_cmp result expect
'

test_expect_success 'Set remote repo' '
        git init --bare remote.git &&
        git remote add origin remote.git
'

printf "origin\tremote.git (fetch)\norigin\tremote.git (push)\n" >expect
test_expect_success 'Check remote setting' '
        git remote -v >result &&
        test_cmp result expect
'

printf "To remote.git
 * [new branch]      toto -> toto
Deleted branch toto (was e303070).
Checkout branch origin/toto
Switched to a new branch 'toto'
Branch toto set up to track remote branch toto from origin.
" >expect
test_expect_success 'Test nbr' '
        git nbr toto >result 2>&1 &&
        test_sha1_cmp result expect
'

printf "  devel
  master
* toto
  remotes/origin/toto
" >expect
test_expect_success 'Test bra' '
        git bra >result &&
        test_cmp result expect
'

printf "toto\n" >expect
test_expect_success 'Test cbr' '
        git cbr >result &&
        test_cmp result expect
'

printf "  devel
* master
" >expect
test_expect_success 'Test dbr' '
        git co master &&
        git dbr toto &&
        git bra >result &&
        test_cmp result expect
'

printf "Deleting titi
To remote.git
 - [deleted]         titi
Deleted branch titi (was 0e24a47).
" >expect
test_expect_success 'Test dbr message' '
        git nbr titi &&
        git co devel &&
        git dbr titi >result 2>&1 &&
        test_sha1_cmp result expect
'

printf "* master\n" >expect
test_expect_success 'Test db' '
        git co master &&
        git db devel &&
        git br >result &&
        test_cmp result expect
'

printf "Deleting local titi
Deleted branch titi (was 2b027c2).
" >expect
test_expect_success 'Test db message' '
        git br titi &&
        git co master &&
        git db titi >result 2>&1 &&
        test_sha1_cmp result expect
'

test_done
