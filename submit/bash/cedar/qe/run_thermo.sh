#! /bin/bash

run_thermo(){
    cat >&3 <<EOM
##xx## Use thermo_pw.x
srun thermo_pw.x -i ${i}.scf.in > ${i}.scf.out

EOM
}
