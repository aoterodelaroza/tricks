#! /bin/bash

init_(){
    cat >&3 <<EOM
module load gcc-8.3.0-gcc-8.2.0-xygalyt
module load openmpi-4.1.1-gcc-8.2.0-5crd33z
module load intel-mkl-2020.0.166-gcc-8.2.0-5sobnda
module load fftw-3.3.8-gcc-8.2.0-kcqedoo

export UCX_LOG_LEVEL=error
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

FHIBIN=/mnt/lustre/home/cfm54626/git/FHIaims/build/aims.230214.scalapack.mpi.x

EOM
}
