# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = docs


SYMLINKS_FILE := symlinks.txt

.PHONY: symlinks
symlinks:
	@echo "Creating symlinks..."
	@while read line; do \
		case $$line in \#*) continue ;; esac; \
		set -- $$line; \
		target=$$1; \
		link=$$2; \
		mkdir -p $$(dirname $$link); \
		[ -e $$link ] || ln -s $$target docs/$$link; \
	done < $(SYMLINKS_FILE)



.PHONY: clean-symlinks
clean-symlinks:
	@echo "Removing symlinks..."
	@while read line; do \
		case $$line in \#*) continue ;; esac; \
		set -- $$line; \
		link=$$2; \
		[ -L docs/$$link ] && rm docs/$$link; \
	done < $(SYMLINKS_FILE)






# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

publish:
	$(SPHINXBUILD) -b html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	touch "$(BUILDDIR)/.nojekyll"



# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
