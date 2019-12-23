#! /bin/bash

init_4-6(){
    cat >&3 <<EOM
module load intel/15.2
module load mkl/15.2
module load openmpi/1.8.4
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export PATH=/opt/vasp/4.6/bin:\$PATH
export VASP=/opt/vasp/4.6/bin/vasp

EOM
}
