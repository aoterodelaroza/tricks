#! /bin/bash

run_gam(){
    cat >&3 <<EOM
time -p mpirun --bind-to core \$A/vasp_gam > ${i}.out

EOM
}
