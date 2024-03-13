#! /bin/bash

init_(){
    cat >&3 <<EOM
module load intel-oneapi-compilers
module load intel-mkl
module load openmpi/4.1.1-cuda11-3

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

FHIBIN=/home/aoterode/src/FHIaims-220915_clean/build/aims.220915.mpi.x

EOM
}
