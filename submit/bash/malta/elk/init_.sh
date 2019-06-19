#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=${ncpu}
. /opt/intel/15.2/bin/ifortvars.sh intel64
. /opt/intel/15.2/mkl/bin/mklvars.sh intel64

EOM
}
