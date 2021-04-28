#! /bin/bash

init_421(){
    cat >&3 <<EOM
module load StdEnv/2020
module load gcc/9.3.0
module load openmpi/4.0.3
module load orca/4.2.1

EOM
}
