#! /bin/bash

run_basic(){
    cat >&3 <<EOM
mpirun \$A/bin/pw.x < ${i}.scf.in > ${i}.scf.out

EOM
}
