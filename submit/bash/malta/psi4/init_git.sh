#! /bin/bash

init_git(){
    cat >&3 <<EOM
module load python/3.7.4
module load intel/15.3
module load mkl/15.3
module load gcc/9.1.0
module load libxc/4.3.4
module load postg/master

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export GOTO_NUM_THREADS=1
export MKL_THREADING_LAYER=GNU
export MKL_INTERFACE_LAYER=GNU
export OMP_NESTED="FALSE"

export PSI_SCRATCH=\${SCRATCH}
export PATH=~/git/psi4/install/bin:\$PATH
export PYTHONPATH=~/git/psi4/install/lib:\$PYTHONPATH
export LD_LIBRARY_PATH=~/git/psi4/install/lib:\$LD_LIBRARY_PATH
export LD_RUN_PATH=~/git/psi4/install/lib:\$LD_RUN_PATH

EOM
}
