#! /bin/bash

run_basic(){
    cat >&3 <<EOM
mpirun -np ${ncpu} \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
