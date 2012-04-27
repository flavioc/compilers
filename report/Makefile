
TARGET = draft

all: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex $(TARGET).bib
	pdflatex $(TARGET).tex
	bibtex $(TARGET)
	pdflatex $(TARGET).tex
	pdflatex $(TARGET).tex

clean:
	rm -f $(TARGET).pdf $(TARGET).log $(TARGET).blg $(TARGET).synctex.gz $(TARGET).aux $(TARGET).bbl
