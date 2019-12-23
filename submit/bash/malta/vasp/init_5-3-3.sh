#! /bin/bash

init_5-3-3(){
    cat >&3 <<EOM
module load intel/15.2
module load mkl/15.2
module load openmpi/1.8.4
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export PATH=/opt/vasp/5.3.3/bin:\$PATH
export VASP=/opt/vasp/5.3.3/bin/vasp5.3.3

EOM
}
