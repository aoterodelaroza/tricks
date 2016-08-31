#! /bin/bash
# latexdraw-compile.sh - script to compile a *.tex file created by latexdraw.
# Usage: compile.sh input .... wil compile input.tex
in=$1
#echo "${in}"
if [ -f "${in}.tex" ]; then
   #texclean
   texfot latex ${in}.tex
   dvipdf ${in}.dvi
   pdfcrop ${in}.pdf
   mv ${in}-crop.pdf ${in}.pdf
   zxpdf  ${in}.pdf
   #grep 'LaTeX Warning' ${in}.log
   #bibtex ${in}
   #texfot pdflatex ${in}.tex
   #texfot pdflatex ${in}.tex
else
   echo "${in}.tex NO existe!!!"
   echo "Use: $0 foo to compile foo.tex!"
fi

