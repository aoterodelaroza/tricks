#! /bin/bash

init_gfn2(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=${ncpu}
export PATH=/home/alberto/git/xtb/_install/bin:\$PATH
export LD_LIBRARY_PATH=/home/alberto/git/xtb/_install/lib64/:\$LD_LIBRARY_PATH
export INITOPTS="--gfn 2"

EOM
}
