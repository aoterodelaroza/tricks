#! /bin/bash

run_dos(){
    cat >&3 <<EOM
mpirun -np \$SLURM_NTASKS \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
mpirun -np \$SLURM_NTASKS \$A/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
