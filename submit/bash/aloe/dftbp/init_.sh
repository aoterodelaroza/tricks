#! /bin/bash

init_(){
    cat >&3 <<EOM
export PATH=/opt/software/dftbplus-24.1/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/dftbplus-24.1/lib/:\$LD_LIBRARY_PATH

EOM
}
