#! /bin/bash

init_(){
    cat >&3 <<EOM
export PATH=/home/alberto/src/dftbplus-20.2.1/_install/bin:\$PATH
export LD_LIBRARY_PATH=/home/alberto/src/dftbplus-20.2.1/_install/lib:\$LD_LIBRARY_PATH

EOM
}
