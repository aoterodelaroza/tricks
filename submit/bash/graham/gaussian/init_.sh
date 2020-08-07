#! /bin/bash

init_(){
    cat >&3 <<EOM
module load gaussian/g16.a03
module load intel/2017.1
export POSTG_HOME=/home/alberto/git/postg
export PATH=~/bin:\${PATH}

EOM
}
