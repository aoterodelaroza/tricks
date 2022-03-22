#! /bin/bash

init_(){
    cat >&3 <<EOM
export PATH=/opt/software/orca_4_2_0/:\$PATH
export LD_LIBRARY_PATH=/opt/software/orca_4_2_0/:\$LD_LIBRARY_PATH
EOM
}
