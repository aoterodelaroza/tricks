#! /bin/bash

init_(){
    cat >&3 <<EOM
unset I_MPI_PMI_LIBRARY
export OMP_NUM_THREADS=${ncpu}
export MKL_NUM_THREADS=1

EOM
}
