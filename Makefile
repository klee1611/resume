.PHONY: all resume.pdf cv.pdf coverletter.pdf clean

CC = xelatex
RESUME_DIR = resume
CV_DIR = cv
CV_LETTER_DIR = coverletter

all: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(RESUME_DIR)/resume.tex
	$(CC) -output-directory=$(RESUME_DIR) $<

cv.pdf: $(CV_DIR)/cv.tex
	$(CC) -output-directory=$(CV_DIR) $<

coverletter.pdf: $(CV_LETTER_DIR)/coverletter.tex
	$(CC) -output-directory=$(CV_LETTER_DIR) $<

clean:
	rm -f $(RESUME_DIR)/*.pdf
	rm -f $(CV_DIR)/*.pdf
	rm -f $(CV_LETTER_DIR)/*.pdf
