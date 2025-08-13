#! /bin/bash

init_(){
    cat >&3 <<EOM
module load StdEnv/2018.3
module load openmpi
export PATH=/home/alberto/src/orca_5_0_4/:\$PATH
export LD_LIBRARY_PATH=/home/alberto/src/orca_5_0_4/:\$LD_LIBRARY_PATH

EOM
}
