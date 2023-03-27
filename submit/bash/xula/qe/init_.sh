#! /bin/bash

init_(){
    cat >&3 <<EOM
spack load gcc@8.3.0
module load intel19
module load intel-mkl-2020.0.166-intel-19.0.5.281-melotrf
module load openmpi-intel19/4.0.4
module load fftw-3.3.8-intel-19.0.5.281-tzxrdbz

export ESPRESSO_TMPDIR=.
export ESPRESSO_HOME=/mnt/lustre/home/cfm54626/src/espresso-6.5_thermo
export PATH=\${ESPRESSO_HOME}/bin:\$PATH
A=\$ESPRESSO_HOME/bin

EOM
}
