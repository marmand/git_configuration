#! /bin/sh

test_description='This desciptions'

# Load git test-suite utilities
. ../git-repo/t/test-lib.sh

test_expect_success '.git/objects should be empty afted git init in an empty repo' '
      find .git/objects -type f -print >should-be-empty &&
      test_line_count = 0 should-be-empty
'

test_done
