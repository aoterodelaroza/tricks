#! /bin/bash

init_qegit(){
    cat >&3 <<EOM
. /home/alberto/src/intel2019/bin/compilervars.sh intel64
export PATH=/home/alberto/bin:\$PATH
export LD_LIBRARY_PATH=/home/alberto/lib:\$LD_LIBRARY_PATH

export ESPRESSO_HOME=/home/alberto/git/espresso
export PATH=\${ESPRESSO_HOME}/bin:\$PATH

EOM
}
