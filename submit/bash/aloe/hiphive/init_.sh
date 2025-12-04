#! /bin/bash

init_(){
    cat >&3 <<EOM
eval "\$(/opt/software/conda/bin/conda shell.bash hook)"

EOM
}
