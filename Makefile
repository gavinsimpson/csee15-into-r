all: slides purl handout

slides: intro-r-slides.Rmd
	Rscript -e "rmarkdown::render(\"intro-r-slides.Rmd\")"

purl: intro-r-slides.Rmd
	Rscript -e "knitr::purl(\"intro-r-slides.Rmd\")"

handout: intro-r-slides.pdf
	pdfnup intro-r-slides.pdf --frame true --outfile handout-intro-r-slides.pdf --delta "0.2cm 0.2cm" --nup 2x2 --scale 0.95
