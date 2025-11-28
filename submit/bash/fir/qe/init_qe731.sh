#! /bin/bash

init_qe731(){
    cat >&3 <<EOM
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=/home/alberto/src/espresso-7.3.1
A=\${ESPRESSO_HOME}/bin/

module load StdEnv/2023
module load intel/2023.2.1
module load imkl/2023.2.0
module load fftw/3.3.10

EOM
}
