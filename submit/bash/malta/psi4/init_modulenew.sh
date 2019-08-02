#! /bin/bash

init_modulenew(){
    cat >&3 <<EOM
source /opt/rh/devtoolset-8/enable
module load psi4/1.3.1-new

EOM
}
