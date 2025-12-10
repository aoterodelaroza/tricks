#! /bin/bash

init_(){
    cat >&3 <<EOM
eval "\$(/opt/software/conda/bin/conda shell.bash hook)"
conda activate hiphive-1.4

EOM
}
