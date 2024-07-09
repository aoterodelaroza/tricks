#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load gcc/9.4.0
module load openmpi/4.1.1-cuda11-3
module load intel-mkl/2020.4.304

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export CRITIC_HOME=/home/aoterode/git/critic2
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=/home/aoterode/src/espresso-7.3.1
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
