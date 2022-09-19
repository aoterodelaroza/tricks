#! /bin/bash

run_(){
	cat >&3 <<EOM

mpiexec -n \$SLURM_NTASKS \$FHIBIN < /dev/null > ${i}.out

EOM
}
