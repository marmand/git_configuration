#! /bin/sh

test_description='Checking that the testing framework works'

# Load git test-suite utilities
. ./test-lib.sh

cat > expect <<\EOF
EOF

test_expect_success 'Checking that git exists' '
        git aliases >result &&
        test_cmp expect result
'

test_done
