#! /usr/bin/awk -f

# usage: cryout2in.awk bleh.out bleh.d12 > new.d12

$0 ~ /^ LATTICE PARAMETERS/ && (FILENAME==ARGV[1]) && $0 ~ /BOHR/{
    getline; getline; getline
    haveparams=1
    a[1]=$1
    a[2]=$2
    a[3]=$3
    b[1]=$4
    b[2]=$5
    b[3]=$6
}
$0 ~ /^ ATOMS IN THE ASYMMETRIC UNIT/ && (FILENAME==ARGV[1]) {
    havecoords=1
    nat=$NF
    getline;getline
    for (i=0;i<nat;i++){
	getline
	zat[i] = $3
	x[i] = $5
	y[i] = $6
	z[i] = $7
    }
}
(FILENAME == ARGV[2]) && FNR==5{
    if (NF == 6)
	print a[1],a[2],a[3],b[1],b[2],b[3]
    else
	print "error! check the number of lattice parameters"
    getline
}
(FILENAME == ARGV[2]) && FNR==6{
    print nat
    getline
    for (i=0;i<nat;i++){
	printf("%s %s %s %s\n",zat[i],x[i],y[i],z[i])
	getline
    }
}
(FILENAME == ARGV[2])
