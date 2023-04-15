SUBDIRS := $(wildcard */.)

.PHONY: clean $(SUBDIRS)

clean: $(SUBDIRS)
	@echo "Cleaning complete"

$(SUBDIRS):
	@echo "Cleaning $@"
	@$(MAKE) -C $@ clean -s || true