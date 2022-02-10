#! /bin/bash

init_aims(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

export ASE_AIMS_COMMAND='mpirun /opt/software/FHIaims_XDM/bin/aims.220115.scalapack.mpi.x'
export AIMS_SPECIES_DIR='/opt/software/FHIaims_XDM/species_defaults/lightdense'

EOM
}
