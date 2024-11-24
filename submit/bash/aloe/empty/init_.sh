#! /bin/bash

init_(){
    cat >&3 <<EOM
module purge
module load StdEnv/2020

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

EOM
}
