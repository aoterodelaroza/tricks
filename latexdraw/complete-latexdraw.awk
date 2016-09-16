#! /usr/bin/gawk -f
# complete-latexdraw.awk -  Transform the *.tex file produced by latexdraw
# when used to ptoduce a PSTRICKS file.
#
# This awk script is used within the compile-latexfraw.sh bash script
# but it can be used by itselt as:
# complete-latexdraw.awk original.tex > complete.tex
#
# (c) 2016, Víctor Luaña, Universidad de Oviedo. Provided for free
#     under the GPLv3 license <https://www.gnu.org/licenses/gpl.html>

BEGIN{
   isltx = "no"
   nltx = 0
}
/Generated with LaTeXDraw/ {
   isltx = "yes"
   # Create first part of file
   line[++nltx] = sprintf("%s","\\documentclass[a4paper,12pt]{article}")
   line[++nltx] = sprintf("%s","\\usepackage[utf8]{inputenc}")
   line[++nltx] = $0
   next
}

isltx=="yes" && /^% \\use/ {
   # Make active the "\usepackage" orders that latex draw comments
   $1 = "";
   line[++nltx] = $0
   next
}

isltx=="yes" &&  /\\scalebox/ {
   # This line is the centinel of pstricks instructions
   # The next orders are required for a compilable tex file
   line[++nltx] = sprintf("%s","\\begin{document}")
   line[++nltx] = sprintf("%s","\\pagestyle{empty}")
   line[++nltx] = $0
   next
}

isltx=="yes" {
   # Copy the rest of lines
   line[++nltx] = $0
      next
   }

END {
   # Complete the file ending the document
   line[++nltx] = sprintf("%s","\\end{document}")
   # Now print everything to complete the tex file
   for (i=1;i<=nltx;i++) {
      print line[i]
   }
}
