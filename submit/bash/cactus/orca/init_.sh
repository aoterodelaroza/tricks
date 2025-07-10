#! /bin/bash

init_(){
    cat >&3 <<EOM
export PATH=/opt/software/orca_6_1_0_avx2/:\$PATH
export LD_LIBRARY_PATH=/opt/software/orca_6_1_0_avx2/:\$LD_LIBRARY_PATH
EOM
}
