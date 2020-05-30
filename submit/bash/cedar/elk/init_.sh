#! /bin/bash

init_(){
    cat >&3 <<EOM
module load intel/2019.3
export OMP_NUM_THREADS=${ncpu}

EOM
}
