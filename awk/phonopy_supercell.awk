#! /usr/bin/awk -f

# usage: phonopy_supercell.awk supercell.scf.in base.scf.in > final
BEGIN{
    if (ARGC != 3){
	print "usage: phonopy_supercell.awk base.scf.in supercell.scf.in > final"
	exit
    }
    aux = ARGV[1]
    ARGV[1] = ARGV[2]
    ARGV[2] = aux
}
ARGIND==1 && /^!/{
    ibrav = $4+0
    nat = $7+0
    ntyp = $(NF)+0
}
ARGIND==1 && /CELL_PARAMETERS/{
    lcell[0] = $0
    for (j=1;j<=3;j++){
	getline
	lcell[j] = $0
    }
}
ARGIND==1 && /ATOMIC_SPECIES/{
    latsp[0] = $0
    for (j=1;j<=ntyp;j++){
	getline
	latsp[j] = $0
    }
}
ARGIND==1 && /ATOMIC_POSITIONS/{
    latpos[0] = $0
    for (j=1;j<=nat;j++){
	getline
	latpos[j] = $0
    }
}
ARGIND==2 && /^ *prefix *=/{
    print " tprnfor=.true.,"
}
ARGIND==2 && /^ *nat *=/{
    gsub("^ *nat *=","")
    nat1 = $0+0
    printf(" nat=%d,\n",nat)
    next
}
ARGIND==2 && /^ *ntyp *=/{
    gsub("^ *ntyp *=","")
    ntyp1 = $0+0
    printf(" ntyp=%d,\n",ntyp)
    next
}
ARGIND==2 && /^ *ibrav *=/{
    gsub("^ *ibrav *=","")
    ibrav1 = $0+0
    printf(" ibrav=%d,\n",ibrav)
    next
}
ARGIND==2 && /^ *CELL_PARAMETERS/{
    print lcell[0]
    for (j=1;j<=3;j++)
	print lcell[j]
    for (j=1;j<=3;j++)
	getline
    next
}
ARGIND==2 && /^ *ATOMIC_SPECIES/{
    print latsp[0]
    for (j=1;j<=ntyp;j++)
	print latsp[j]
    for (j=1;j<=ntyp1;j++)
	getline
    next
}
ARGIND==2 && /^ *ATOMIC_POSITIONS/{
    print latpos[0]
    for (j=1;j<=nat;j++)
	print latpos[j]
    for (j=1;j<=nat1;j++)
	getline
    next
}
ARGIND==2{print}
