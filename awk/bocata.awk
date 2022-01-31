#! /usr/bin/awk -f

BEGIN{
    if (ARGC < 4){
	print "usage: bocata.awk prefix file1 ... filen postfix"
	exit
    }
    prefix = ARGV[1]
    postfix = ARGV[ARGC-1]
    for (i = 1; i < ARGC-2; i++)
	ARGV[i] = ARGV[i+1]
    ARGC = ARGC - 2
}
{
    printf("%s%s%s\n",prefix, $0, postfix)
}
