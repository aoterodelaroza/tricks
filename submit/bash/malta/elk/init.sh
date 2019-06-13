#! /bin/bash

init(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=${nomp}
. /opt/intel/15.2/bin/ifortvars.sh intel64
. /opt/intel/15.2/mkl/bin/mklvars.sh intel64

cd $(pwd)/${i}
/home/alberto/src/elk-4.3.6/src/elk 2>&1 > elk.out

EOM
}
