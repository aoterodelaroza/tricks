#! /bin/bash

run_density(){
    cat >&3 <<EOM
##xx## For density: use pp.x on .rho.in and on .rhoae.in
mpirun \$A/pp.x < ${i}.rho.in > ${i}.rho.out
mpirun \$A/pp.x < ${i}.rhoae.in > ${i}.rhoae.out

EOM
}
