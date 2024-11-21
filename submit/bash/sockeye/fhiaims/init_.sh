#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load intel-oneapi-compilers/2023.1.0
module load openmpi/4.1.6-cuda12-4 cmake intel-mkl

export UCX_WARN_UNUSED_ENV_VARS=n
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

## FHIBIN=/home/aoterode/src/FHIaims-xdm-stable/build/aims.240507.mpi.x
FHIBIN=/home/aoterode/src/FHIaims-241018/build/aims.241018.mpi.x

EOM
}
