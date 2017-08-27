#! /usr/bin/awk -f
BEGIN{
    usage = "\n" \
    "    mean.awk -- calculate the mean of a field in a text file \n" \
    "\n" \
    "    Usage : \n" \
    "\n" \
    "        mean.awk [-k field] [-b block] file\n" \
    "            Calculates the mean of the specified fields in the file (the\n" \
    "            default field is the first). A block is delimited by a blank\n"   \
    "            line. If -b is found, only the lines of the given block are\n" \
    "            calculated. The first block is 0, gnuplot style. \n" \
    "\n"
}
BEGIN{
    k = 1
    b = -1

    while(i<=ARGC-1){
	i++
	if (tolower(ARGV[i]) == "-b")
	    b = ARGV[++i]
	else if (tolower(ARGV[i]) == "-k")
	    k = ARGV[++i]
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
/^#/{ next }
(bf == b) || (b < 0){ sum += $k ; n++ }
END{
    if (n>0) 
	printf "%.15f\n",sum/n
}
