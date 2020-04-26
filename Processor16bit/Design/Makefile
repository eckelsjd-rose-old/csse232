all: designdoc 

designdoc: BAEJ.md
	@echo "MAKING DESIGN DOCUMENT (BAEJ.pdf)..."
	@pandoc BAEJ.md --from markdown-implicit_figures-markdown_in_html_blocks+raw_html -t latex -V geometry:margin=1in -s -o BAEJ.tex
	@-pdflatex -interaction=nonstopmode BAEJ.tex > /dev/null || true
	@rm BAEJ.aux BAEJ.log BAEJ.out BAEJ.tex
	@echo "DONE"

designdoc_pretty: BAEJ.md
	@echo "MAKING DESIGN DOCUMENT (BAEJ.pdf)..."
	@pandoc BAEJ.md --from markdown-implicit_figures-markdown_in_html_blocks+raw_html -t latex --template nicepdf -V geometry:margin=1in -s -o BAEJ.tex
	@-pdflatex -interaction=nonstopmode BAEJ.tex > /dev/null || true
	@rm BAEJ.aux BAEJ.log BAEJ.out BAEJ.tex
	@echo "DONE"

datapath: datapath.svg
	@echo "MAKING DATAPATH DIAGRAM (datapath.pdf)..."
	@rsvg-convert -f pdf -o datapath.pdf datapath.svg
	@echo "DONE"

clean:
	@echo "CLEANING"
	@rm BAEJ.aux BAEJ.log BAEJ.out BAEJ.tex
