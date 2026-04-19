#!/usr/bin/env python3

from pathlib import Path
import sys


def main() -> int:
    try:
        import fitz  # PyMuPDF
    except ImportError:
        print(
            "PyMuPDF is required to generate preview assets.\n"
            "Install it with: python -m pip install pymupdf",
            file=sys.stderr,
        )
        return 1

    repo_root = Path(__file__).resolve().parents[1]
    assets_dir = repo_root / "assets"
    assets_dir.mkdir(exist_ok=True)

    pdf_targets = [
        (repo_root / "cv.pdf", "cv-preview"),
        (repo_root / "resume.pdf", "resume-preview"),
        (repo_root / "cover-letter.pdf", "cover-letter-preview"),
    ]

    for pdf_path, prefix in pdf_targets:
        if not pdf_path.exists():
            print(f"Missing required PDF: {pdf_path}", file=sys.stderr)
            return 1

        for old_file in assets_dir.glob(f"{prefix}-page-*.png"):
            old_file.unlink()

        with fitz.open(pdf_path) as doc:
            for index, page in enumerate(doc, start=1):
                pixmap = page.get_pixmap(matrix=fitz.Matrix(1.35, 1.35), alpha=False)
                pixmap.save(assets_dir / f"{prefix}-page-{index}.png")

            print(f"Generated {len(doc)} preview page(s) for {pdf_path.name}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
