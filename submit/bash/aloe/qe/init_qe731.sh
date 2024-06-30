#! /bin/bash

init_qe731(){
    cat >&3 <<EOM
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

export ESPRESSO_HOME=/opt/software/espresso-7.3.1
A=\${ESPRESSO_HOME}/bin/

. /opt/software/intel/oneapi/setvars.sh
export PATH=/opt/software/openmpi-4.1.6_intel/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/openmpi-4.1.6_intel/lib/:\$LD_LIBRARY_PATH

EOM
}
