#! /bin/bash

run_(){
    cat >&3 <<EOM
srun \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
