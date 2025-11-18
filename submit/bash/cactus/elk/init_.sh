#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_PROC_BIND=false
export OMP_STACKSIZE=512M
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

. /opt/software/intel/oneapi/setvars.sh
export PATH=/opt/software/openmpi-4.1.6_intel/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/openmpi-4.1.6_intel/lib/:\$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/software/fftw-3.3.10/lib/:\$LD_LIBRARY_PATH

EOM
}
