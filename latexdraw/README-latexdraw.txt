DESCRIPTION OF THE latexdraw UTILITIES
--------------------------------------

(c) 2016, Víctor Luaña, Universidad de Oviedo (Spain)
    Freeware licensed under the GNU Free Documentation License
    <https://www.gnu.org/licenses/fdl.html>

The latexdraw project is the development of a graphical PSTricks editor or
generator for latex. It is open-source and free.  The latest versions are
maintained and developed on <latexdraw.sourceforge.net>. As of this writing
this corresponds to version to 3.3.3.  It is currently adapted to work
on Linux, Windows, and Mac OS X. Java 1.7 is required to launch LaTeXDraw.

Adapting to use latexdraw requires some effort:

1) Determine the best route to use the excellents images that can be created
2) Complete apropriately the *.tex files containing the psticks codes
3) Compile the *.tex files to produce the final image that can be used in
   other TeX documents or elsewhere.

To simplify the efforts I created two simple but useful utilities:

A) complete-latexdraw.awk - A gawk script that ornates the raw latexdraw
   *.tex file in order to be latex compilable.
B) compile-latexdraw.sh - A bash script to produce and see the final PDF
   file.

The working model I have been using is:

a) Create the illustration with latexdraw. TeX text can use single lines
   like this equation: $n=\frac{pV}{RT$.
b) Keep the project *.svg for future modifications
c) Export the PSTRICK code. Let it bee foo.tex, for instance
d) Call  compile-latexdraw foo
d) Use the foo.pdf file

Included in the zip is a simple example:

I) maxwell.svg: the original illustration
II) maxwell.tex: the raw pstricks
III) maxwell.pdf: the final plot
