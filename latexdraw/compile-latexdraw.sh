#! /bin/bash
# latexdraw-compile.sh - script to compile a *.tex file created by latexdraw.
# Usage: compile.sh input .... wil compile input.tex
# (c) 2016, Víctor Luaña, Universidad de Oviedo. Provided for free
#     under the GPLv3 license <https://www.gnu.org/licenses/gpl.html>
#
# Requirements:
# * This code use the texfot perl script to call latex.
#   you can obtain it on <https://www.ctan.org/pkg/texfot> but if this
#   is inappropriate you can remove it or use a bare alias:
# * CTAN pdfcropt is used to remove blank space around
#   <https://www.ctan.org/pkg/pdfcrop>
# ^ zxpdf is currently used to see the final pdf (change to whatever fits)
#
# Create bare alias (remove the # in front of next line):
# alias texfot=""
#
in=$1
in2="${in}-vlc"
#echo "${in}"
if [ -f "${in}.tex" ]; then
   #texclean
   complete-latexdraw.awk ${in}.tex > ${in2}.tex
   texfot latex ${in2}.tex
   dvipdf ${in2}.dvi
   pdfcrop ${in2}.pdf
   mv ${in2}-crop.pdf ${in}.pdf
   mv ${in2}.pdf ${in}.pdf
   zxpdf  ${in}.pdf
   rm ${in2}.*
else
   echo "${in}.tex NO existe!!!"
   echo "Use: $0 foo to compile foo.tex!"
fi

