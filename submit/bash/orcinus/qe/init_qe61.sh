#! /bin/bash

init_qe61(){
    cat >&3 <<EOM
. /home/alberto/src/intel2019/bin/compilervars.sh intel64
export PATH=/home/alberto/bin:\$PATH
export LD_LIBRARY_PATH=/home/alberto/lib:\$LD_LIBRARY_PATH

export ESPRESSO_HOME=/home/alberto/src/espresso-6.1
export PATH=\${ESPRESSO_HOME}/bin:\$PATH

EOM
}
