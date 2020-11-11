#! /bin/bash

run_basic(){
    cat >&3 <<EOM
srun -n \$SLURM_NTASKS --mpi=pmi2 \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
