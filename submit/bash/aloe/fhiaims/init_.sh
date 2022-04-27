#! /bin/bash

init_(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
export CRITIC_HOME="/home/alberto/git/critic2"
ulimit -s unlimited

EOM
}
