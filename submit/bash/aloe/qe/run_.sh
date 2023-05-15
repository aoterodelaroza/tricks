#! /bin/bash

run_(){
    cat >&3 <<EOM
mpirun \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
