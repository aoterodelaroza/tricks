#! /bin/bash

init_qe66(){
    cat >&3 <<EOM
module load quantumespresso/6.6
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=\${EBROOTQUANTUMESPRESSO}
A=\${ESPRESSO_HOME}/bin/

module load StdEnv/2023
module load intel/2024.2.0
module load imkl/2024.2.0

EOM
}
