#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE

module load intel/2023.1
module load mkl/2023.1
module load libxc/5.2.2

EOM
}
