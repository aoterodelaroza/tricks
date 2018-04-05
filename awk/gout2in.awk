#! /usr/bin/awk -f

BEGIN{
    RS="\r\n|\n"
    if (ARGC != 3){
	print "Usage: gout2in.awk bleh.log bleh.gjf"
	exit
    }
}

(FILENAME==ARGV[1]) && (/Standard orientation: *$/ || /Input orientation: *$/) {
    gotnew = 1
    nat = 0
    getline; getline; getline; getline; getline
    while ($0 !~ /----/){
	nat++
	zat[nat] = $2
	x[nat] = $4
	y[nat] = $5
	z[nat] = $6
	getline
    }
}
(FILENAME == ARGV[2]) && $0 ~ /^ *$/{
    nblank++
}
(FILENAME == ARGV[2]) && (nblank == 2){
    getline; 
    print ""
    print 
    for (i=1;i<=nat;i++){
	getline
	printf "%s %.10f %.10f %.10f\n", $1, x[i], y[i], z[i]
    }
    next
}
(FILENAME == ARGV[2])
