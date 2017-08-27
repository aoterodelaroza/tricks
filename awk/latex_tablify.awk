#! /usr/bin/awk -f
BEGIN{
    usage = "\n" \
	"latex_tablify.awk -- casts a table in latex format.\n" \
	"\n" \
	"Usage : \n" \
	"\n" \
	"  latex_tablify.awk [-b block] [-k k1 k2 k3 ... ] file\n" \
	"       Generates a table from the field-formatted file.\n" \
	"       latex_tablify.awk automatically detects alphabetic columns,\n" \
	"       positive/negative numbers (includes the phantom command)\n" \
	"       and the need for exponential notation. Optionally, the number\n" \
	"       of significant digits for each field may be set in the input\n" \
	"       file using a line starting with '#@'.\n" \
	"       With -b, a block of data is selected, gnuplot style. If no -b\n" \
	"       appears, all the blocks are used, with an hline between them.\n" \
	"       A subset of the fields can be extracted using the -k option.\n" \
	"\n"
}
BEGIN{
    b = -1

    while(i<=ARGC-1){
	i++
	if (tolower(ARGV[i]) == "-b")
	    b = ARGV[++i]
	else if (tolower(ARGV[i]) == "-k"){
	    for (i++;ARGV[i] ~ /^[0-9]+$/;i++){
		factive[ARGV[i]] = 1
		fsel = 1
	    }
	    i--
	}
	else if (tolower(ARGV[i]) == "-h"){
	    print usage
	    exit
	}
	else
	    break
    }

    ARGV[1] = ARGV[i]
    ARGC = ARGC - i + 1
}
(blanks == 2) { bf++ ; blanks = 0 }
/^( |\t)*$/{ blanks++ ; next }
{ blanks = 0 }
/^#@/{
    # read decimal places of the fields
    for (i=2;i<=NF;i++)
	prec[i-1] = $i + 0
}
/^#/{next}
(bf == b) || (b < 0){ 
    if (NF > nfields) 
	nfields = NF
    recs++
    for (i=1;i<=NF;i++){
	if ($i !~ /^[+-]?[0-9]*\.?[0-9]*([eEdDqQ][+-]?[0-9]+)*$/)
	    anum[i] = 1
	if (!anum[i]){
	    $i += 0
	    if ($i < 0)
		neg[i] = 1
	    if ($i != 0 && (abs($i) < 0.1 || abs($i) >= 10.0))
		useexp[i] = 1
	}
	field[recs,i] = $i
    }
    block[recs] = bf
}
END{
    # inital comment
    print "% This table has been generated with latex_tablify.awk"
    print "% Blocks :", (b<0)?"all":b
    line = "% Fields : "
    if (fsel)
	for (i in factive)
	    line = line i " "
    else
	line = line "all"
    print line
    line = "% Significant digits (per field):"
    for (i=1;i<=nfields;i++)
	line = line " " (prec[i]+0!=0?prec[i]:"unspec") " "
    print line
    
    # header
    line = "\\begin{tabular}{"
    for (i=1;i<=nfields;i++){
	if (fsel && !factive[i]) continue
	if (anum[i])
	    line = line "c"
	else
	    line = line "l"
    }
    line = line "}"
    print line
    for (i=1;i<=recs;i++){
	line = ""
	for (j=1;j<=nfields;j++){
	    if (fsel && !factive[j]) continue
	    if (anum[j]){
		line = line field[i,j]
	    }
	    else{
		field[i,j] += 0
		line = line "$"
		if (neg[j] && field[i,j] > 0)
		    line = line "\\phantom{-}"
		if (useexp[j]){
		    if (prec[j]+0 != 0)
			str = sprintf("%.*E",prec[j]-1,field[i,j])
		    else
			str = sprintf("%E",field[i,j])
		    ind = index(str,"E")
		    expon = substr(str,ind+1) + 0
		    if (expon != 0) {
			gsub(/E.*$/,"\\times 10^{",str)
			str = str sprintf("%d",expon) "}"
		    }
		    else{
			gsub(/E.*$/,"",str)
		    }
		    line = line str
		}
		else{
		    if (prec[j]+0 != 0)
			if (abs(field[i,j]) < 1)
			    line = line sprintf("%.*f",prec[j],field[i,j])
			else
			    line = line sprintf("%.*f",prec[j]-1,field[i,j])
		    else
			line = line sprintf("%f",field[i,j])
		}
		line = line "$"
	    }
	    line = line " & "
	}
	gsub(/& *$/,"\\\\",line)
	print line
	if (i != recs && block[i+1] != block[i])  
	    print "\\hline"
    }
    # tailer
    print "\\end{tabular}"
}
function abs(local2_x){
    return local2_x>0?local2_x:-local2_x
}
