# CV, Resume, and Cover Letter

This repository contains three related LaTeX document variants:

- `cv/` — fuller, multi-page curriculum vitae
- `resume/` — denser, whitespace-optimized single-page resume
- `cover-letter/` — standard cover letter template with fill-in placeholders

Style and shared content live in `shared/` to avoid duplication across documents.

## Preview

[Download the CV PDF](./cv.pdf)

[Download the Resume PDF](./resume.pdf)

[Download the Cover Letter PDF](./cover-letter.pdf)

## CV Preview

### Page 1

![CV preview page 1](./assets/cv-preview-page-1.png)

### Page 2

![CV preview page 2](./assets/cv-preview-page-2.png)

### Page 3

![CV preview page 3](./assets/cv-preview-page-3.png)

## Resume Preview

### Page 1

![Resume preview page 1](./assets/resume-preview-page-1.png)

### Page 2

![Resume preview page 2](./assets/resume-preview-page-2.png)

## Structure

```
cv/                   CV-specific style and section files
  resume.sty
  main.tex
  sections/
resume/               Resume-specific section files
  main.tex
  sections/
cover-letter/         Cover letter section files
  main.tex
  sections/
shared/               Shared between resume and cover-letter
  resume.sty          Common LaTeX style package
  sections/
    header.tex        Name, title, and contact line
scripts/              Build helper scripts
assets/               Generated PNG previews
```

The root `Makefile` builds all three PDFs. The CV uses its own `resume.sty`
(different margins and font settings); `resume` and `cover-letter` share
`shared/resume.sty` via `TEXINPUTS`.

## Requirements

You need `make` and a LaTeX engine. The default build uses `pdflatex`.

## Build

Build all documents:

```sh
make
```

This generates `cv.pdf`, `resume.pdf`, and `cover-letter.pdf`.

Generate the README preview assets after building:

```sh
make assets
```

This regenerates the PNG previews in `assets/` from all three PDFs. Requires `uv` — PyMuPDF is fetched automatically via `uv run`, no manual dependency installation needed.

Build only the CV:

```sh
make cv
```

Build only the resume:

```sh
make resume
```

Build only the cover letter:

```sh
make cover-letter
```

If you want to use a different engine, override `LATEX`:

```sh
make LATEX=xelatex
```

If `pdflatex` is not installed, the `Makefile` will print a clear error message instead of failing silently.

The `Makefile` also supports `tectonic`:

```sh
make LATEX=tectonic
```

## Clean generated files

Run:

```sh
make clean
```

## Customization

Update `shared/sections/header.tex` with your personal details (used by both resume and cover letter).
Update `cv/sections/header.tex` separately for the CV.

Replace the content in the `cv/sections/`, `resume/sections/`, and `cover-letter/sections/` files with your own material.

Fill in the `[placeholder]` fields in `cover-letter/sections/body.tex` for each application.

To adjust formatting, edit `cv/resume.sty` for the CV or `shared/resume.sty` for the resume and cover letter.
