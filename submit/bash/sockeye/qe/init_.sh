#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load intel-oneapi-compilers/2023.1.0
module load openmpi/4.1.6-cuda12-4 cmake intel-mkl

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export CRITIC_HOME=/home/aoterode/git/critic2
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=/home/aoterode/src/espresso-6.5_thermo
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
