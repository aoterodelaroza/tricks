#! /bin/bash

init(){
    cat >&3 <<EOM
module load vasp/5.4.1

cd $(pwd)/${i}

EOM
}
