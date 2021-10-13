#! /bin/bash

init_(){
    cat >&3 <<EOM
module --force purge
module load intel
module load intelmpi/2019.7.217
export PATH=/home/alberto/src/mrcc.2020-02-22_binary:\$PATH

EOM
}
