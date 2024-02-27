#! /bin/bash

init_qe65(){
    cat >&3 <<EOM
module load intel-openapi-compilers
module load intel-mkl
module load openmpi/4.1.1-cuda11-3

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export CRITIC_HOME=/home/aoterode/git/critic2
export ESPRESSO_TMPDIR=/tmp
export ESPRESSO_HOME=/home/aoterode/src/espresso-6.5_thermo
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
