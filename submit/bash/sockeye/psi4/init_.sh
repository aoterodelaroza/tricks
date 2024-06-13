#! /bin/bash

init_(){
    cat >&3 <<EOM
source /etc/profile
module load gcc/5.4.0
module load python/3.7.3
module load intel-mkl/2019.3.199
module load py-pip

export PATH=/home/aoterode/src/psi4/bin/:/home/aoterode/git/postg:\$PATH
export PSIDATADIR=/home/aoterode/src/psi4/share/psi4/
export PSI_SCRATCH=\${SLURM_TMPDIR}
export LIBRARY_PATH=/home/aoterode/src/psi4/lib/:\$LIBRARY_PATH
export CPATH=/home/aoterode/src/psi4/include/:\$CPATH
export KMP_INIT_AT_FORK=FALSE

EOM
}
