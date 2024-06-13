#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load gcc/9.4.0
module load openmpi/4.1.1-cuda11-3

## orca
export LD_LIBRARY_PATH=/home/aoterode/src/orca_5_0_3:\$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=\$OPENMPI_ROOT/lib:\$LD_LIBRARY_PATH

EOM
}
