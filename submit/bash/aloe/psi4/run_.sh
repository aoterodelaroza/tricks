#! /bin/bash

run_(){
	cat >&3 <<EOM
psi4 -i ${i}.inp -o ${i}.out -n ${ncpu} ${AMP}

EOM
}
