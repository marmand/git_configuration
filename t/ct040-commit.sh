#! /bin/sh

test_description='Checking branch aliases'

# Load git test-suite utilities
. ./ctest-lib.sh
. ./test-lib.sh

test_expect_success 'Setup commit aliases' '
      configurate_with alias commits
'

printf "one" >expect
test_expect_success 'Alias lg' '
      echo one >one &&
      git add one &&
      git commit -m "one" &&
      git alias lg "log --pretty=\"format:%s\"" &&
      git lg >result &&
      test_cmp result expect
'

printf "two\none" >expect
test_expect_success 'Test ci' '
      echo two >two &&
      git add two &&
      git ci -m "two" &&
      git lg >result &&
      test_cmp result expect
'

printf "three\none" >expect
test_expect_success 'Test cia' '
      echo three >three &&
      git add three &&
      git cia -m "three" &&
      git lg >result &&
      test_cmp result expect
'

test_done
