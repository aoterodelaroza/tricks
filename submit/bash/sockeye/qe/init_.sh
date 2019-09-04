#! /bin/bash

init_(){
    cat >&3 <<EOM
module load gcc/5.4.0
module load intel-mkl/2019.3.199
module load openmpi/3.1.4

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export CRITIC_HOME=/home/aoterode/git/critic2
export ESPRESSO_TMPDIR=/tmp
export ESPRESSO_HOME=/home/aoterode/git/espresso
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
