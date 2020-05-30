#! /bin/bash

init_5-4-4(){
    cat >&3 <<EOM
module load intel/15.2
module load mkl/15.2
module load openmpi/4.0.1
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export PATH=/opt/uovi/alberto/vasp-5.4.4.pl2/bin/:\$PATH
export VASP=/opt/uovi/alberto/vasp-5.4.4.pl2/bin/vasp_std

EOM
}
