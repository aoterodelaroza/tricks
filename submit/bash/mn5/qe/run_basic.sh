#! /bin/bash

run_basic(){
    cat >&3 <<EOM
srun pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
