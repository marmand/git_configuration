#! /bin/sh

test_description='Checking checkout aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup checkout aliases' '
        configurate_with checkout
'

test_done
