#! /bin/bash

init_myorca(){
    cat >&3 <<EOM
module load openmpi
export PATH=/home/alberto/src/orca_4_0_1/:\$PATH
export LD_LIBRARY_PATH=/home/alberto/src/orca_4_0_1/:\$LD_LIBRARY_PATH

EOM
}
