.PHONY: clean strip all see re
SHELL=/bin/bash

files=$(wildcard *.tex)
pdfs=$(patsubst %.tex,%.pdf, $(files))
auxs=$(patsubst %.tex,%.aux, $(files))
logs=$(patsubst %.tex,%.log, $(files))

all: $(pdfs)

%.pdf: %.tex *.cls
	pdflatex $<
	-bibtex $(patsubst %.tex,%,$<)
	pdflatex $<
	pdflatex $<

clean:
	rm -f $(pdfs)
	rm -f $(auxs)
	rm -f $(logs)

re: clean all

watch:
	on-change.sh -n $(files) $(wildcard *.cls) $(wildcard *.bib) -- make
