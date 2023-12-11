#! /bin/bash

run_(){
    cat >&3 <<EOM
mpiexec -n \$SLURM_NTASKS \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
