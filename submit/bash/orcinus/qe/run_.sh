#! /bin/bash

run_(){
    cat >&3 <<EOM
mpirun -np ${nmpi} pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
