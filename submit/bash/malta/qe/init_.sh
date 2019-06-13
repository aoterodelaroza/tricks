!#! /bin/bash

init_(){
    cat >&3 <<EOM
module load intel/15.3
module load mkl/15.3
module load openmpi/1.8.4
module load fftw/3.3.4.1
export ESPRESSO_HOME=/opt/uovi/alberto/espresso-6.1

export ESPRESSO_TMPDIR=\${TMPDIR}
export PATH=\$ESPRESSO_HOME/bin:\$PATH

EOM
}
