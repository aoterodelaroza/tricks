#! /bin/bash

init_(){
    cat >&3 <<EOM
unset I_MPI_PMI_LIBRARY
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

module --force purge
module load StdEnv/2020  intel/2020.1.217  openmpi/4.0.3
module load quantumespresso/7.2

EOM
}
