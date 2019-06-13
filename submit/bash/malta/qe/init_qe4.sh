#! /bin/bash

init_qe4(){
    cat >&3 <<EOM
. /opt/intel/15.2/bin/ifortvars.sh intel64
. /opt/intel/15.2/mkl/bin/mklvars.sh intel64
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/fftw/3.3.4.1/lib
export ESPRESSO_HOME=/opt/uovi/alberto/espresso-4.3.2

export ESPRESSO_TMPDIR=\${TMPDIR}
export PATH=\$ESPRESSO_HOME/bin:\$PATH

cd $(pwd)/${i}

EOM
}
