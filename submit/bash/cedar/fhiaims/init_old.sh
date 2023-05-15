#! /bin/bash

init_old(){
    cat >&3 <<EOM
module purge
module load StdEnv/2020
module load intel/2020.1.217 imkl/2020.1.217 openmpi/4.0.3
module load libxc/5.1.3

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

FHIBIN=/home/alberto/src/FHIaims_XDM/build/aims.210513.mpi.x

EOM
}
