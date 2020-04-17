#! /bin/bash

init_qemodule(){
    cat >&3 <<EOM
module load intel
module load espresso
unset I_MPI_PMI_LIBRARY

EOM
}
