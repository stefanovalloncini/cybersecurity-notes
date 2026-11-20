MAIN  = main
SHELL = /bin/sh

PROJECT_ROOT := $(shell pwd)

TEXLIVE_BIN := $(shell ls -d /usr/local/texlive/20*/bin/universal-darwin 2>/dev/null | sort -r | head -1)
ifneq ($(TEXLIVE_BIN),)
export PATH := $(TEXLIVE_BIN):$(PATH)
endif

OUTDIR  = out
LATEXMK = latexmk

.PHONY: all watch chapter check check-tools clean distclean install-hooks help

all: check-tools
	@mkdir -p $(OUTDIR)
	$(LATEXMK) -outdir=$(OUTDIR) $(MAIN).tex

watch: check-tools
	@mkdir -p $(OUTDIR)
	$(LATEXMK) -outdir=$(OUTDIR) -pvc $(MAIN).tex

chapter: check-tools
	@if [ -z "$(name)" ]; then echo "Usage: make chapter name=01"; exit 1; fi; \
	CHAPTER_FILE=$$(find chapters -maxdepth 1 -name "*$(name)*.tex" | sort | head -n 1); \
	if [ -z "$$CHAPTER_FILE" ]; then echo "Error: chapter '$(name)' not found in chapters/"; exit 1; fi; \
	mkdir -p $(OUTDIR)/chapters; \
	$(LATEXMK) -cd -outdir=$(PROJECT_ROOT)/$(OUTDIR)/chapters "$$CHAPTER_FILE"

check: all
	@sh scripts/check-build.sh $(OUTDIR)/$(MAIN)

check-tools:
	@biber --version >/dev/null 2>&1 || { echo "Error: biber does not run (see 'biber --version' and Troubleshooting in README.md)."; exit 1; }
	@latexminted --version >/dev/null 2>&1 || { echo "Error: latexminted does not run; minted needs it to highlight code."; exit 1; }

clean:
	find . -path ./.git -prune -o -type f \( -name "*.aux" -o -name "*.log" -o -name "*.out" \
		-o -name "*.toc" -o -name "*.lof" -o -name "*.lot" \
		-o -name "*.fls" -o -name "*.fdb_latexmk" \
		-o -name "*.synctex.gz" -o -name "*.synctex(busy)" -o -name "*.xdv" \
		-o -name "*.bbl" -o -name "*.blg" -o -name "*.bcf" -o -name "*.run.xml" \
		-o -name "*.pyg" -o -name "*.data.minted" \) -print -delete
	find . -type d -name "_minted*" -exec rm -rf {} + 2>/dev/null || true

distclean: clean
	rm -rf $(OUTDIR)

install-hooks:
	git config core.hooksPath .githooks
	@echo "Hooks installed (.githooks/pre-commit will run on every commit)."

help:
	@echo "Targets:"
	@echo "  all              build out/main.pdf"
	@echo "  watch            rebuild on every change"
	@echo "  chapter name=XX  build a single chapter -> out/chapters/ (e.g. name=01)"
	@echo "  check            build, then fail on errors, warnings, bad boxes or biber warnings"
	@echo "  check-tools      verify that biber and latexminted run"
	@echo "  clean            remove temp files (keep PDFs)"
	@echo "  distclean        remove out/ entirely"
	@echo "  install-hooks    use .githooks/ as the git hooks dir"
