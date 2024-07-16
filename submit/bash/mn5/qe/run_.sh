#! /bin/bash

run_(){
    cat >&3 <<EOM
srun pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
