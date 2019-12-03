#! /bin/bash

init_qegit(){
    cat >&3 <<EOM
module load intel
export ESPRESSO_HOME=/home/alberto/git/espresso
export PATH=\${ESPRESSO_HOME}/bin:\$PATH
unset I_MPI_PMI_LIBRARY

EOM
}
