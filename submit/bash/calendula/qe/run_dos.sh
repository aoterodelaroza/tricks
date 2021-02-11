#! /bin/bash

run_dos(){
    cat >&3 <<EOM
srun -n \$SLURM_NTASKS --mpi=pmi2 \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
srun -n \$SLURM_NTASKS --mpi=pmi2 \$A/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
