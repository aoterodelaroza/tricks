#! /bin/bash

init_qe65thermo(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

module load intel
module load fftw
export ESPRESSO_HOME=/home/alberto/src/espresso-6.5_thermo
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
