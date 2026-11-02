.PHONY: build test eval run
build test eval run:
	$(MAKE) -C core $@
