LATEX ?= pdflatex
LATEXFLAGS ?= -interaction=nonstopmode -halt-on-error

.PHONY: all cv resume cover-letter assets clean clean-cv clean-resume clean-cover-letter

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

resume.pdf: resume/main.tex resume/resume.sty $(wildcard resume/sections/*.tex)
	@command -v $(LATEX) >/dev/null 2>&1 || { echo "Error: $(LATEX) not found. Install a LaTeX engine or run 'make LATEX=<engine>'."; exit 1; }
	@if [ "$(LATEX)" = "tectonic" ]; then \
		cd resume && $(LATEX) --keep-logs --keep-intermediates --outdir .. main.tex; \
		mv -f ../main.pdf ../resume.pdf; \
	else \
		cd resume && $(LATEX) $(LATEXFLAGS) main.tex && $(LATEX) $(LATEXFLAGS) main.tex && cp -f main.pdf ../resume.pdf; \
	fi

cover-letter.pdf: cover-letter/main.tex cover-letter/resume.sty $(wildcard cover-letter/sections/*.tex)
	@command -v $(LATEX) >/dev/null 2>&1 || { echo "Error: $(LATEX) not found. Install a LaTeX engine or run 'make LATEX=<engine>'."; exit 1; }
	@if [ "$(LATEX)" = "tectonic" ]; then \
		cd cover-letter && $(LATEX) --keep-logs --keep-intermediates --outdir .. main.tex; \
		mv -f ../main.pdf ../cover-letter.pdf; \
	else \
		cd cover-letter && $(LATEX) $(LATEXFLAGS) main.tex && cp -f main.pdf ../cover-letter.pdf; \
	fi

clean:
	rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk cv.pdf resume.pdf cover-letter.pdf
	rm -f cv/*.aux cv/*.log cv/*.out cv/*.toc cv/*.fls cv/*.fdb_latexmk cv/*.xdv cv/*.pdf
	rm -f resume/*.aux resume/*.log resume/*.out resume/*.toc resume/*.fls resume/*.fdb_latexmk resume/*.xdv resume/*.pdf
	rm -f cover-letter/*.aux cover-letter/*.log cover-letter/*.out cover-letter/*.toc cover-letter/*.fls cover-letter/*.fdb_latexmk cover-letter/*.xdv cover-letter/*.pdf
