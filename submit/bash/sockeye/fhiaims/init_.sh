#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load intel-oneapi-compilers
module load intel-mkl
module load openmpi/4.1.1-cuda11-3

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

FHIBIN=/home/aoterode/src/FHIaims-xdm-stable/build/aims.240507.mpi.x

EOM
}
