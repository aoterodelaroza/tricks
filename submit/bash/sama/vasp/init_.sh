#! /bin/bash

init_(){
    cat >&3 <<EOM
module load GCCcore/11.2.0
module load imkl/2021.4.0
module load OpenMPI/4.1.1-GCC-11.2.0
export LD_LIBRARY_PATH=/home/alberto/src/fftw-3.3.10/.libs:\$LD_LIBRARY_PATH

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
export CRITIC_HOME="/home/alberto/git/critic2"
ulimit -s unlimited

EOM
}
