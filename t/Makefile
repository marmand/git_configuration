GIT_TEST_OPTS= --verbose --debug
TEST_LINT = test-lint-duplicates test-lint-executable test-git
T= t0-base.sh

check: $(TEST_LINT)
	$(MAKE) aggregate-results-and-cleanup

$(T):
	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL)' $@ $(GIT_TEST_OPTS)


test-lint-duplicates:
	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
		test -z "$$dups" || { \
		echo >&2 "duplicate test numbers:" $$dups; exit 1; }

test-lint-executable:
	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
		test -z "$$bad" || { \
		echo >&2 "non-executable tests:" $$bad; exit 1; }

aggregate-results-and-cleanup: $(T)
	$(MAKE) aggregate-results
	$(MAKE) clean

aggregate-results:
	for f in test-results/t*-*.counts; do \
		echo "$$f"; \
	done | '$(SHELL)' ../git-repo/t/aggregate-results.sh

test-git:
	. $$PWD/functions; 				\
	for f in GIT-BUILD-OPTIONS bin-wrappers; 	\
	do 						\
	  ln_s $$f; 					\
	done
	for f in test-lib-functions.sh; \
	do 				\
	  cp ../git-repo/t/$$f .; 	\
	done

clean:

# End of Test Makefile
