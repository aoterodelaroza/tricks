#! /bin/bash

run_(){
    cat >&3 <<EOM
mpirun -np \$SLURM_NTASKS \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
