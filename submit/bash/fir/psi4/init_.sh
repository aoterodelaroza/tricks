#! /bin/bash

init_(){
    cat >&3 <<EOM
module load cmake intel/17 python/3.7 scipy-stack boost hdf5

export PATH=/home/alberto/src/psi4/bin/:/home/alberto/git/postg:\$PATH
export PSIDATADIR=/home/alberto/src/psi4/share/psi4/
export PSI_SCRATCH=\${SLURM_TMPDIR}
export LIBRARY_PATH=/home/alberto/src/psi4/lib/:\$LIBRARY_PATH
export CPATH=/home/alberto/src/psi4/include/:\$CPATH
export KMP_INIT_AT_FORK=FALSE

EOM
}
