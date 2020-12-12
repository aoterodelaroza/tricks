#! /bin/bash

init_(){
    cat >&3 <<EOM
## orca
#module load openmpi/2.0.2 ## this one for orca_4_0_1
module load intel/15.3
export LD_LIBRARY_PATH=/home/alberto/src/orca_4_2_0/:\$LD_LIBRARY_PATH
export PATH=/home/alberto/src/orca_4_2_0/:\$PATH

## postg
export POSTG_HOME=/opt/uovi/alberto/postg
export PATH=\${PATH}:\${POSTG_HOME}
export OMP_NUM_THREADS=${ncpu}

EOM
}
