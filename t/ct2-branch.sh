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

test_done
