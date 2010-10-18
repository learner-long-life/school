TEX_DETRITUS =	*.aux *.log *~ *.toc *.bbl *.blg *.log *.lot *.lof \
		*.dvi *.ps *.pdf *.bak

MAKE_TEXINPUTS = .#:$(TOP_DIR)/thesis:$(TOP_DIR)/manual
MAKE_BIBINPUTS = .:$(TOP_DIR)/thesis
MAKE_BSTINPUTS = .:$(TOP_DIR)/thesis

SEQUENCER_FILENAME = sequencer-$(FILENAME)

FIGURES_TEX = $(FIGURES:.pic=.tex)
FIGURES_PS = $(FIGURES:.pic=.ps)

SPELL_BACKUP_FILES = $(TEX_FILES:.tex=.tex.bak)

PIC = gpic

# LaTeX command passing command-line arguments
LATEX = latex "\def\draft{${DRAFT}}\def\files{${FILES}}\input{main}";

###############################################################################
# LaTeX definitions
ifndef FILES
FILES := all
endif

ifdef FINAL
DRAFT := final
endif

ifndef DRAFT
DRAFT := draft
endif

ifdef SPELL
SPELL_FILES := $(SPELL_BACKUP_FILES)
endif

###############################################################################
# Targets

all: ps pdf

clean:
	rm -Rf $(TEX_DETRITUS)
	rm -Rf $(SEQUENCER_FILENAME).ps $(SEQUENCER_FILENAME).pdf
	rm -Rf $(FIGURES_TEX) $(FIGURES_PS) $(GRAPHS) *.relyx1 *.relyx2
	cd figures; rm -Rf $(TEX_DETRITUS)
	cd graphs; rm -Rf $(TEX_DETRITUS)

$(SEQUENCER_FILENAME).ps: main.ps
	rm -Rf $@
	ln -s $< $@

$(SEQUENCER_FILENAME).pdf: main.pdf
	rm -Rf $@
	ln -s $< $@

main.bbl: $(BIB_FILE) $(TEX_FILES)
	TEXINPUTS=$(MAKE_TEXINPUTS):${TEXINPUTS}; export TEXINPUTS; \
	BIBINPUTS=$(MAKE_BIBINPUTS):${BIBINPUTS}; export BIBINPUTS; \
	$(LATEX) \
	bibtex main.aux;                                                     \

main.dvi: $(FIGURES_TEX) $(TEX_FILES) $(GRAPHS) $(SPELL_FILES) main.bbl
	TEXINPUTS=$(MAKE_TEXINPUTS):${TEXINPUTS}; export TEXINPUTS; \
	BIBINPUTS=$(MAKE_BIBINPUTS):${BIBINPUTS}; export BIBINPUTS; \
	$(LATEX) \
	$(LATEX) \

ps: $(SEQUENCER_FILENAME).ps
pdf: $(SEQUENCER_FILENAME).pdf

tex: $(TEX_FILES)

figures: $(FIGURES_TEX)

graphs: $(GRAPHS)

template: figures
	TEXINPUTS=..:${TEXINPUTS}; export TEXINPUTS;    \
        TEXCONFIG=.:${TEXCONFIG}; export TEXCONFIG;     \
	cd figures;                                     \
	latex template.tex;                             \
	dvips -f -P amz -P cmz < template.dvi > template.ps; \
	gv template.ps

slides-ppad.tex: complexity.tex dummy.tex

###############################################################################
# Rules

%.tex : %.pic
	$(PIC) -t $< > $*.tex

%.dvi: %.tex
	latex $< $@
	latex $< $@

%.ps: %.dvi
	dvips -Ppdf -G0 -t letter -f < $< > $@

%.pdf: %.dvi
	dvipdf $< $@

ASPELL_TEX_COMMANDS = 				\
	--add-tex-command="inputencoding p"	\
	--add-tex-command="rmdefault p"		\
	--add-tex-command="ttdefault p"		\
	--add-tex-command="sfdefault p"		\

%.tex.bak: %.tex
	aspell -t -S --home-dir=. -p .ispell-sequencer $(ASPELL_TEX_COMMANDS) -c $<
