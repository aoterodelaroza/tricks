#! /bin/bash

init_(){
    cat >&3 <<EOM
module load GCCcore/11.2.0
module load imkl/2021.4.0
module load OpenMPI/4.1.1-GCC-11.2.0

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

export LD_LIBRARY_PATH=/home/alberto/src/fftw-3.3.10/.libs:\${LD_LIBRARY_PATH}

export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export CRITIC_HOME="/home/alberto/git/critic2"

export ESPRESSO_HOME=/home/alberto/src/espresso-6.5_thermo
A=\${ESPRESSO_HOME}/bin/

EOM
}
