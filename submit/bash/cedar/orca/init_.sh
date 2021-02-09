#! /bin/bash

init_(){
    cat >&3 <<EOM
module load openmpi
## module load openmpi/2.0.2
export PATH=/home/alberto/src/orca_4_0_1/:\$PATH
export LD_LIBRARY_PATH=/home/alberto/src/orca_4_0_1/:\$LD_LIBRARY_PATH

EOM
}
