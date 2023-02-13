#! /bin/bash

run_basic(){
    cat >&3 <<EOM
mpirun \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
