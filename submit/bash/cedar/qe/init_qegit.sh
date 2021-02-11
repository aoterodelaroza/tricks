#! /bin/bash

init_qegit(){
    cat >&3 <<EOM
unset I_MPI_PMI_LIBRARY
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

module --force purge
module load StdEnv/2016.4
module load intel/2017.5
module load imkl/2017.1.132
module load fftw-mpi/3.3.6
module load libxc
module load openmpi/2.1.1
export ESPRESSO_HOME=/home/alberto/git/espresso
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
