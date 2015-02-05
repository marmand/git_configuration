#! /bin/sh

test_description='Checking checkout aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup checkout aliases' '
        configurate_with checkout
'

printf "  devel\n* master\n" >expect
test_expect_success 'Simple checkout' '
        echo one >one &&
        git add one &&
        git commit -m "one" &&
        git checkout -b devel &&
        echo two >two &&
        git add two &&
        git commit -m "two" &&
        git co master &&
        git branch >result &&
        test_cmp result expect
'

printf "* devel\n  master\n" >expect
test_expect_success 'Another one' '
        git co devel &&
        git branch >result &&
        test_cmp result expect
'

test_expect_success 'Setup remote' '
        git init --bare remote.git &&
        git remote add origin remote.git
'

printf "* devel
  master
  remotes/origin/tata
  remotes/origin/titi
  remotes/origin/toto
" >expect
test_expect_success 'Setup branches on remote' '
        git push origin HEAD:toto &&
        git push origin HEAD:tata &&
        git push origin HEAD:titi &&
        git branch -a > result &&
        test_cmp result expect
'

printf "  devel
  master
* tata
" >expect
test_expect_success 'Test cob alias' '
        git cob tata &&
        git branch >result &&
        test_cmp result expect
'

printf "Checkout branch origin/titi
Branch titi set up to track remote branch titi from origin.
" >expect
test_expect_success 'Test cob output' '
        git cob titi >result &&
        test_cmp result expect
'

test_done
