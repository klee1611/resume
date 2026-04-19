LATEX ?= pdflatex
LATEXFLAGS ?= -interaction=nonstopmode -halt-on-error

# Resume and cover-letter share a style from shared/; expose it via TEXINPUTS.
# Prepended as an inline env assignment (POSIX sh / bash only — not Windows).
SHARED_TEXINPUTS = TEXINPUTS=.:../shared//:

.PHONY: all cv resume cover-letter assets clean

all: cv.pdf resume.pdf cover-letter.pdf assets

cv: cv.pdf

resume: resume.pdf

cover-letter: cover-letter.pdf

assets: cv.pdf resume.pdf cover-letter.pdf
	@uv run --with pymupdf python3 scripts/generate_assets.py

cv.pdf: cv/main.tex cv/resume.sty $(wildcard cv/sections/*.tex)
	@command -v $(LATEX) >/dev/null 2>&1 || { echo "Error: $(LATEX) not found. Install a LaTeX engine or run 'make LATEX=<engine>'."; exit 1; }
	@if [ "$(LATEX)" = "tectonic" ]; then \
		cd cv && $(LATEX) --keep-logs --keep-intermediates --outdir .. main.tex; \
		mv -f ../main.pdf ../cv.pdf; \
	else \
		cd cv && $(LATEX) $(LATEXFLAGS) main.tex && $(LATEX) $(LATEXFLAGS) main.tex && cp -f main.pdf ../cv.pdf; \
	fi

resume.pdf: resume/main.tex shared/resume.sty shared/sections/header.tex $(wildcard resume/sections/*.tex)
	@command -v $(LATEX) >/dev/null 2>&1 || { echo "Error: $(LATEX) not found. Install a LaTeX engine or run 'make LATEX=<engine>'."; exit 1; }
	@if [ "$(LATEX)" = "tectonic" ]; then \
		cd resume && $(SHARED_TEXINPUTS) $(LATEX) --keep-logs --keep-intermediates --outdir .. main.tex; \
		mv -f ../main.pdf ../resume.pdf; \
	else \
		cd resume && $(SHARED_TEXINPUTS) $(LATEX) $(LATEXFLAGS) main.tex && $(SHARED_TEXINPUTS) $(LATEX) $(LATEXFLAGS) main.tex && cp -f main.pdf ../resume.pdf; \
	fi

cover-letter.pdf: cover-letter/main.tex shared/resume.sty shared/sections/header.tex $(wildcard cover-letter/sections/*.tex)
	@command -v $(LATEX) >/dev/null 2>&1 || { echo "Error: $(LATEX) not found. Install a LaTeX engine or run 'make LATEX=<engine>'."; exit 1; }
	@if [ "$(LATEX)" = "tectonic" ]; then \
		cd cover-letter && $(SHARED_TEXINPUTS) $(LATEX) --keep-logs --keep-intermediates --outdir .. main.tex; \
		mv -f ../main.pdf ../cover-letter.pdf; \
	else \
		cd cover-letter && $(SHARED_TEXINPUTS) $(LATEX) $(LATEXFLAGS) main.tex && $(SHARED_TEXINPUTS) $(LATEX) $(LATEXFLAGS) main.tex && cp -f main.pdf ../cover-letter.pdf; \
	fi

clean:
	rm -f cv.pdf resume.pdf cover-letter.pdf
	rm -f cv/*.aux cv/*.log cv/*.out cv/*.toc cv/*.fls cv/*.fdb_latexmk cv/*.xdv cv/*.pdf
	rm -f resume/*.aux resume/*.log resume/*.out resume/*.toc resume/*.fls resume/*.fdb_latexmk resume/*.xdv resume/*.pdf
	rm -f cover-letter/*.aux cover-letter/*.log cover-letter/*.out cover-letter/*.toc cover-letter/*.fls cover-letter/*.fdb_latexmk cover-letter/*.xdv cover-letter/*.pdf
