#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load intel-oneapi-compilers
module load intel-mkl
module load openmpi/4.1.1-cuda11-3
export LD_LIBRARY_PATH=/arc/software/spack-2024/opt/spack/linux-rocky9-skylake_avx512/intel-2023.2.0/fftw-3.3.10-tpy2nilylq6rdgnrg3ealkw4kh2wt33f/lib/:\$LD_LIBRARY_PATH

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export CRITIC_HOME=/home/aoterode/git/critic2
export ESPRESSO_TMPDIR=\${SLURM_TMPDIR}
export ESPRESSO_HOME=/home/aoterode/src/espresso-7.3.1
export PATH=\$PATH:\${ESPRESSO_HOME}/bin
A=\$ESPRESSO_HOME/bin

EOM
}
