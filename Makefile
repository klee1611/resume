TARGET ?= resume
MAIN ?= main.tex
LATEX ?= pdflatex
LATEXFLAGS ?= -interaction=nonstopmode -halt-on-error

.PHONY: all clean

all: $(TARGET).pdf

$(TARGET).pdf: $(MAIN) resume.sty $(wildcard sections/*.tex)
	@command -v $(LATEX) >/dev/null 2>&1 || { echo "Error: $(LATEX) not found. Install a LaTeX engine or run 'make LATEX=<engine>'."; exit 1; }
	@if [ "$(LATEX)" = "tectonic" ]; then \
		$(LATEX) --keep-logs --keep-intermediates --outdir . $(MAIN); \
		mv -f $$(basename $(MAIN) .tex).pdf $(TARGET).pdf; \
	else \
		$(LATEX) $(LATEXFLAGS) -jobname=$(TARGET) $(MAIN); \
		$(LATEX) $(LATEXFLAGS) -jobname=$(TARGET) $(MAIN); \
	fi

clean:
	rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk $(TARGET).pdf
