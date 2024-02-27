#! /bin/bash

run_(){
    cat >&3 <<EOM
mpirun \$A/pw.x < ${i}.scf.in > ${i}.scf.out 2>&1 ${AMP}

EOM
}
