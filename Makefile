.PHONY: build test eval eval-dev run
build test eval eval-dev run:
	$(MAKE) -C core $@
