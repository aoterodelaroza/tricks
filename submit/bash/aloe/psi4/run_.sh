#! /bin/bash

run_(){
	cat >&3 <<EOM
psi4 -i ${i}.inp -o ${i}.out -n \${SLURM_CPUS_ON_NODE} ${AMP}

EOM
}
