FILENAME = oss-and-search
PIC = gpic

all: beamer article

beamer: ${FILENAME}.beamer.pdf

article: beamer ${FILENAME}.article.pdf

handout: ${FILENAME}.handout.pdf

clean:
	rm -Rf *.pdf *.log *.aux *~ *.out *.toc *.nav *.snm

%.pdf: %.tex ${FILENAME}.tex
	pdflatex $<
	pdflatex $<

%.tex : %.pic
	$(PIC) -t $< | awk -f ~/texmf/tex/latex/tpic2pdftex.awk > $*.tex
