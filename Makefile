all:
	xelatex Thesis
	open Thesis.pdf

bib:
	xelatex Thesis; bibtex Thesis; xelatex Thesis; xelatex Thesis
