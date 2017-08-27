#! /usr/bin/awk -f

# usage: pwout2in.awk bleh.scf.out bleh.scf.in > new.scf.in

/^ *CELL_PARAMETERS/{
    if (FILENAME==ARGV[1]){
	iscell = 1
	getline; cell[1] = $0
	getline; cell[2] = $0
	getline; cell[3] = $0
    } else {
	if (iscell){
	    print $0
	    for (i=1;i<=3;i++)
		print cell[i]
	    getline; getline; getline;
	} else {
	    print $0
	    for (i=1;i<=3;i++){
		getline;
		print $0
	    }
	}
    }
    next
}
/^ *ATOMIC_POSITIONS/,/^ *$/{
    if (FILENAME == ARGV[1]){
	isatom = 1
	if ($0 ~ /ATOMIC/){
	    nat = 0;
	} else if ($0 !~ /^ *$/ && $0 !~ "final"){
	    nat = nat + 1
	    x[nat] = $0
	}
    }
    else{
	if (isatom){
	    if ($0 ~ /ATOMIC/){
		print $0
		for (i=1;i<=nat;i++)
		    print x[i]
	    } else if ($0 ~ /^ *$/ && $0 !~ "final"){
		print $0
	    }
	    next
	}
    }
}
(FILENAME == ARGV[2])
