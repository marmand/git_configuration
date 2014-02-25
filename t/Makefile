

#GIT_TEST_OPTS= --verbose --debug
TEST_LINT_CT = test-lint-duplicates-ct test-lint-executable-ct

check: $(TEST_LINT_CT)
	$(MAKE) aggregate-results-and-cleanup

$(CT):
	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL)' $@ $(GIT_TEST_OPTS)


test-lint-duplicates-ct:
	@dups=`echo $(CT) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
		test -z "$$dups" || { \
		echo >&2 "duplicate test numbers:" $$dups; exit 1; }

test-lint-executable-ct:
	@bad=`for i in $(CT); do test -x "$$i" || echo $$i; done` && \
		test -z "$$bad" || { \
		echo >&2 "non-executable tests:" $$bad; exit 1; }

aggregate-results-and-cleanup: $(CT)

.PHONY: $(CT) check

# End of Test Makefile
