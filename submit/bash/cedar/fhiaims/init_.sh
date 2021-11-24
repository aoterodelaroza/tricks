#! /bin/bash

init_(){
    cat >&3 <<EOM
module purge
module load StdEnv/2020
module load intel/2020.1.217 intelmpi/2019.7.217 imkl/2020.1.217
module load libxc/5.1.3

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

EOM
}
