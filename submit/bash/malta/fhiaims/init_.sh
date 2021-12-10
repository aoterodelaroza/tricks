#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1

module load intel/15.2
module load mkl/15.2
export PATH=/home/alberto/src/FHIaims_XDM/build/:/home/alberto/openmpi-4.0.4/bin/:\$PATH

EOM
}
