#! /bin/bash

run_density(){
    cat >&3 <<EOM
##xx## For density: use pp.x on .rho.in and on .rhoae.in
srun pp.x < ${i}.rho.in > ${i}.rho.out
srun pp.x < ${i}.rhoae.in > ${i}.rhoae.out

EOM
}
