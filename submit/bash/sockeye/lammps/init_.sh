#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load gcc/5.4.0
module load openmpi/3.1.4
module load intel-mkl

export PATH=/home/aoterode/src/lammps-7Aug19/src:\$PATH
export KMP_INIT_AT_FORK=FALSE

EOM
}
