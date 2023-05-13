#! /bin/bash

init_(){
    cat >&3 <<EOM
spack load gcc@8.3.0
module load openmpi-4.1.1-gcc-8.2.0-5crd33z
export PATH=/mnt/lustre/home/cfm54626/src/orca_5_0_3/:\$PATH
export LD_LIBRARY_PATH=/mnt/lustre/home/cfm54626/src/orca_5_0_3/:\$LD_LIBRARY_PATH

EOM
}
