#! /bin/bash

init_(){
    cat >&3 <<EOM
module load StdEnv/2023
module load intel/2023.2.1
module load imkl/2023.2.0
module load fftw/3.3.10

FHIBIN=/home/alberto/src/FHIaims/build/aims.251014.scalapack.mpi.x

EOM
}
