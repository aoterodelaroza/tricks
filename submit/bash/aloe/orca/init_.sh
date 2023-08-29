#! /bin/bash

init_(){
    cat >&3 <<EOM
export PATH=/opt/software/orca_5_0_4/:\$PATH
export LD_LIBRARY_PATH=/opt/software/orca_5_0_4/:\$LD_LIBRARY_PATH
EOM
}
