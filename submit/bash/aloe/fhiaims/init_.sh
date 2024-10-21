#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
export CRITIC_HOME="/home/alberto/git/critic2"
ulimit -s unlimited

. /opt/software/intel/oneapi/setvars.sh
export PATH=/opt/software/openmpi-4.1.6_intel/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/openmpi-4.1.6_intel/lib/:\$LD_LIBRARY_PATH

export FHIAIMS=/opt/software/FHIaims/bin/aims.241018.scalapack.mpi.x

EOM
}
