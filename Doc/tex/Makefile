#
# Makefile zum Erzeugen des Skripts
#

RM = /bin/rm -f
MKDIR = /bin/mkdir
CP = /bin/cp
ZIP = /usr/bin/zip
LATEX = /usr/bin/pdflatex
BIBTEX = /usr/bin/biber

tutorial.pdf: tutorial.tex References.bib
	$(LATEX) tutorial.tex
	$(BIBTEX) tutorial
	$(LATEX) tutorial.tex
	$(LATEX) tutorial.tex

clean:
	-$(RM) *.aux *.dvi *.log *.out *.toc *~ *.bbl *.blg *.bcf *.run.xml
	-$(RM) *~ */*.aux */*~

purge: clean
	-$(RM) tutorial.pdf
