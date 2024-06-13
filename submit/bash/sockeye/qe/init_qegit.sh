#! /bin/bash

init_qegit(){
    cat >&3 <<EOM
source /etc/profile
module load gcc/9.1.0
module load openmpi/3.1.4

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export CRITIC_HOME=/home/aoterode/git/critic2
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=/home/aoterode/git/espresso
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
