#! /bin/bash

run_hubbard(){
    cat >&3 <<EOM
##xx## For hubbard: run the scf, scf2, and hp
srun \$A/pw.x < ${i}.scf2.in > ${i}.scf2.out
srun \$A/hp.x < ${i}.hp.in > ${i}.hp.out

EOM
}
