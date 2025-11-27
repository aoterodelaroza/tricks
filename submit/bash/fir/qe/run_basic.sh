#! /bin/bash

run_basic(){
    cat >&3 <<EOM

time srun \$A/pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
