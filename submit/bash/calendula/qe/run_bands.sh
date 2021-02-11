#! /bin/bash

run_bands(){
    cat >&3 <<EOM
##xx## For bands: run the nscf and bands.x
srun -n \$SLURM_NTASKS --mpi=pmi2 \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
srun -n \$SLURM_NTASKS --mpi=pmi2 \$A/bands.x < ${i}.bands.up.in > ${i}.bands.up.out
srun -n \$SLURM_NTASKS --mpi=pmi2 \$A/bands.x < ${i}.bands.dn.in > ${i}.bands.dn.out

EOM
}
