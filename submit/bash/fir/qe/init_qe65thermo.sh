#! /bin/bash

init_qe65thermo(){
    cat >&3 <<EOM
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=/home/alberto/src/espresso-6.5_thermo
A=\${ESPRESSO_HOME}/bin/

module load StdEnv/2023
module load intel/2024.2.0
module load imkl/2024.2.0

EOM
}
