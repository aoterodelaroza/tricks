#! /bin/bash

run_basic(){
    cat >&3 <<EOM
mpirun -np ${nmpi} pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
