#! /bin/bash

run_(){
    cat >&3 <<EOM
mpirun \$GULP < ${i}.gin > ${i}.gout ${AMP}

EOM
}
