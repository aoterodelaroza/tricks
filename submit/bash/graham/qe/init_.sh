#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

module load quantumespresso/6.1
A=\$(dirname \$(which pw.x))

EOM
}
