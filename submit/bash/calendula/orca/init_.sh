#! /bin/bash

init_(){
    cat >&3 <<EOM
## some info, just in case
echo "hostname : \$(hostname)"
echo "date : \$(date)"

## postg
export POSTG_HOME=/home/udo97/udo97373/git/postg
export PATH=\${PATH}:\${POSTG_HOME}
export OMP_NUM_THREADS=${ncpu}

## orca
## export LD_LIBRARY_PATH=/home/udo97/udo97373/src/orca_4_0_1/:/home/udo97/udo97373/.local/lib/:\$LD_LIBRARY_PATH
## export PATH=/home/udo97/udo97373/src/orca_4_0_1/:\$PATH

. /etc/profile.d/modules.sh
module load sandybridge/orca_4.2.0

EOM
}
