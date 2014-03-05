#! /bin/sh

test_description='Checking aliases'

# Load git test-suite utilities
. ./test-lib.sh

test_expect_success 'Checking that aliases alias does not exists' '
        test_must_fail git aliases >result &&
        test_must_be_empty result
'

test_done
