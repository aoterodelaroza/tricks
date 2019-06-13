#! /bin/bash

run(){
    cat >&3 <<EOM
mpirun -np ${nmpi} \$A/pw.x < ${i}.scf.in > ${i}.scf.out

EOM
}
