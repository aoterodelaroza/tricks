#! /usr/bin/gawk -f
# txt2wxm.awk # Converts a commented ascii textfile into a wxmaxima
# worksheet.
# 
# Use as:  txt2wxm.awk input > worksheet.wxm
# Once the worksheet is completed you can enter it in wxmaxima
# as: wxmaxima ./worksheet.wxm
#
# (c) 2016, June Víctor Luaña
#     (victor@fluor.quimica.uniovi.es)
#     (victor.luana@gmail.com)
#
# Language reecognized by the awk preprocessor:
# #O file .. Direct the output to the file
#            Make sure that the file name contains no blanks
# #T<n>  ... Include the next part of this line as a text remark in the wxm.
#            The n value indicates the importance level of the remark:
# #TI title ........ General title.
# #TS section ...... Section title
# #TSS sub ......... Subsection
# #TR text ......... General text with no special emphasis level.
# # text ........... General text with no special emphasis level.
#
# Any other line is assumed to be language to be interpreted by wxmaxima.
# and classified as "code"
# 
# Several lines with the same classification level will be grouped as the
# same cell in the wxm file. A code line that ends in a ";" will mark the
# end of a cell.
#

BEGIN{
   nc=0
   output="/dev/stdout"
   logfile = "txt2wxm.log"
   printf("# txt2wxm.awk\n") > logfile
# Three fundamental types: none, text, code
   ty_none = 666
   ty_text = 2
   ty_code = 1
   status = ty_none
# Several levels of text: title, section, subsection, normal text
   ty_title = 21
   ty_sec = 22
   ty_subsec = 23
   ty_text = 20
   types[ty_code] = ty_code;     stype[ty_code] = "Code";
   types[ty_title] = ty_title;   stype[ty_title] = "Title";     
   types[ty_sec] = ty_sec;       stype[ty_sec] = "Section"; 
   types[ty_subsec] = ty_subsec; stype[ty_subsec] = "Subsection";  
   types[ty_text] = ty_text;     stype[ty_text] = "Text";    
   end_cell = false
   sbeg[ty_title]  = "/* [wxMaxima: title   start ]"
   send[ty_title]  = "   [wxMaxima: title   end   ] */"
   sbeg[ty_sec]    = "/* [wxMaxima: section start ]"
   send[ty_sec]    = "   [wxMaxima: section end   ] */"
   sbeg[ty_subsec] = "/* [wxMaxima: subsect start ]"
   send[ty_subsec] = "   [wxMaxima: subsect end   ] */"
   sbeg[ty_text]   = "/* [wxMaxima: comment start ]"
   send[ty_text]   = "   [wxMaxima: comment end   ] */"
   sbeg[ty_code] = "/* [wxMaxima: input   start ] */"
   send[ty_code] = "/* [wxMaxima: input   end   ] */"
}

function new_cell(typ){
   cell_ty[++nc] = typ
   cell_nl[nc] = 0
   return(nc)
   }
function cell_add(n,s){
   if (length(s) > 0) {
      cell_nl[n] += 1
      nl = cell_nl[n]
      cell_line[n,nl] = s
      }
   }
function out_start(){
   s0 = "/* [wxMaxima batch file version 1] [ DO NOT EDIT BY HAND! ]*/"
   s1 = "/* [ Created with wxMaxima version 13.04.2 ] */"
   printf("%s\n",s0) > output
   printf("%s\n",s1) >> output
   }
function out_end(){
   s0 = "/* Maxima can't load/batch files which end with a comment! */"
   s1 = "Created with txt2wxm.awk"
   printf("%s\n",s0) >> output
   printf("%s\n",s1) >> output
   }
function out_cell(i,sbeg,send){
   if (cell_nl[i] >= 1) {
      printf("%s\n",sbeg) >> output
      lines = cell_nl[i]
      for (l=1;l<=lines; l++) {
         printf("%s\n", cell_line[i,l]) >> output
         }
      printf("%s\n",send) >> output
      }
   }

/^#/ {
   old_status = status; old_text = text_ty
   if (toupper($0) ~ /^#O /) {
      output=$2
      status = ty_none
      next}
   else if (toupper($0) ~ /^#TI /) {text_ty = ty_title; s = substr($0,5)}
   else if (toupper($0) ~ /^#TS /) {text_ty = ty_sec; s = substr($0,5)}
   else if (toupper($0) ~ /^#TSS /) {text_ty = ty_subsec; s = substr($0,6)}
   else if (toupper($0) ~ /^#TR /) {text_ty = ty_text; s = substr($0,5) }
   else if (toupper($0) ~ /^#T /) {text_ty = ty_text; s = substr($0,4) }
   else if (toupper($0) ~ /^# *$/) {next}
   else if (toupper($0) ~ /^#/) {text_ty = ty_text; s = substr($0,2) }
   else {printf("ERR1: unknown text type\n%s\n", $0) >>logfile}
   status = ty_text

   #printf("%d - %s\n", NR, $0) >> logfile
   #printf("%s -- %s -- ", stype[status], stype[text_ty]) >> logfile
   if (old_status!=status) {
      nc =new_cell(text_ty)
      cell_add(nc,s)
      }
   else if (old_text!=text_ty) {
       nc = new_cell(text_ty)
       cell_add(nc,s)
       }
   else { cell_add(nc,s) }
   #printf("%d,%d\n", nc,cell_nl[nc] ) >> logfile
   }

!/^#/ {
   s = $0
   if (end_cell) {
      status=ty_code
      nc = new_cell(status)
      cell_add(nc,s)
   }
   else if (status==ty_code) {cell_add(nc,s)}
   else {
      status=ty_code
      nc = new_cell(status)
      cell_add(nc,s)
      }
   # Find if the line ands in a ";". Declare this represents the end
   # of this cell.
   ss = gensub(/[ \t]+$/,"","g",s)
   ls = length(ss)
   end_cell = substr(ss,ls,1)==";"
   }

END{
   out_start()
   for (i=1; i<=nc; i++) {
      typ = cell_ty[i]
      n[typ] += 1
      s0 = sbeg[typ]; s1 = send[typ]
      out_cell(i,s0,s1)
   }
   out_end()
   printf("Cells: %d\n", nc) >> logfile
   for (t in stype) {
      printf("type: %s n: %d\n", stype[t], n[t]) >> logfile
      }
   for (i=1; i<=nc; i++) {
      t = cell_ty[i]
      printf("%06d %6s nl: %d\n",i, stype[t], cell_nl[i]) >> logfile
   }
}
