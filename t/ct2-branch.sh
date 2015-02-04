#! /bin/sh

test_description='Checking branch aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup branch aliases' '
        configurate_with branch
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

test_done
