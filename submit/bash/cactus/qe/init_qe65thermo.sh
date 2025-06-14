#! /bin/bash

init_qe65thermo(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

export ESPRESSO_HOME=/opt/software/espresso-6.5_thermo
A=\${ESPRESSO_HOME}/bin/

EOM
}
