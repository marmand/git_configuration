#! /bin/sh

test_description='Checking aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Checking that aliases alias does not exists' '
        test_must_fail git aliases >result &&
        test_must_be_empty result
'

test_expect_success 'Setup aliases alias' '
        configurate_with alias
'

test_expect_success 'Launch alias alias' '
      echo "usage: git alias <new alias> <original command>" >expect &&
      test_expect_code 1 git alias 2>result &&
      test_cmp result expect
'

test_done
