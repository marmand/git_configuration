#! /bin/sh

test_description='Checking that the testing framework works'

# Load git test-suite utilities
. ./test-lib.sh

cat > expect <<\EOF
git version 1.9.0
EOF
test_expect_success 'Checking that git exists' '
        git --version >result &&
        test_cmp expect result
'

test_done
