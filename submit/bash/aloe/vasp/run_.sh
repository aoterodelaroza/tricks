#! /bin/bash

run_(){
    cat >&3 <<EOM
time -p mpirun --bind-to core \$A/vasp_std > ${i}.out

EOM
}
