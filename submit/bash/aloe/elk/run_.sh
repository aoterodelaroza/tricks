#! /bin/bash

run_(){
    cat >&3 <<EOM
mpirun \$ELK 2>&1 > elk.out ${AMP}

EOM
}
