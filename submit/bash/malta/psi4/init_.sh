#! /bin/bash

init_(){
    cat >&3 <<EOM
module load python/3.7.4
module load psi4/1.3.1

EOM
}
