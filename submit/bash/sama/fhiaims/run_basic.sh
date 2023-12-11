#! /bin/bash

run_basic(){
	cat >&3 <<EOM
mpiexec -n \$SLURM_NTASKS \$FHIBIN < /dev/null > ${i}.out ${AMP}

EOM
}
