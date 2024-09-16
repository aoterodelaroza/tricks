#! /bin/bash

init_(){
    cat >&3 <<EOM
module load GCCcore/11.2.0
module load imkl/2021.4.0
module load OpenMPI/4.1.1-GCC-11.2.0

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
export CRITIC_HOME="/home/alberto/git/critic2"
ulimit -s unlimited

## FHIBIN=/home/alberto/git/FHIaims/build/aims.220915.scalapack.mpi.x
FHIBIN=/home/alberto/git/FHIaims-xdm-stable/build/aims.240507.scalapack.mpi.x
EOM
}
