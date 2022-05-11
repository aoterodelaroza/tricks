#! /bin/bash

init_(){
    cat >&3 <<EOM
module load openmpi
export PATH=/home/alberto/src/orca_5_0_3/:\$PATH
export LD_LIBRARY_PATH=/home/alberto/src/orca_5_0_3/:\$LD_LIBRARY_PATH

EOM
}
