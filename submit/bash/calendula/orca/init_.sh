#! /bin/bash

init_(){
    cat >&3 <<EOM
## orca
## export LD_LIBRARY_PATH=/home/udo97/udo97373/src/orca_4_0_1/:/home/udo97/udo97373/.local/lib/:\$LD_LIBRARY_PATH
## export PATH=/home/alberto/src/orca_4_0_1/:\$PATH

module load sandybridge/orca_4.2.0

# ## postg
# export POSTG_HOME=/opt/uovi/alberto/postg
# export PATH=\${PATH}:\${POSTG_HOME}
# export OMP_NUM_THREADS=${ncpu}

EOM
}
