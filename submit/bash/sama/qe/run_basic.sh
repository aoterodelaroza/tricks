#! /bin/bash

run_basic(){
    cat >&3 <<EOM
mpiexec -n \$SLURM_NTASKS \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
