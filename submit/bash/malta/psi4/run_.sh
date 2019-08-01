#! /bin/bash

run_(){
	cat >&3 <<EOM
psi4 ${i}.inp ${i}.dat ${AMP}

EOM
}
