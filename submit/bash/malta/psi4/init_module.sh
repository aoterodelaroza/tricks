#! /bin/bash

init_module(){
    cat >&3 <<EOM
module load python/3.7.4
module load psi4/1.3.1

export MKL_THREADING_LAYER=GNU
export MKL_INTERFACE_LAYER=GNU
export OMP_NESTED="FALSE"

EOM
}
