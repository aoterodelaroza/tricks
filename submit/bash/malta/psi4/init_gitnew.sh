#! /bin/bash

init_gitnew(){
    cat >&3 <<EOM
source /opt/rh/devtoolset-8/enable

module load intel/15.3 
module load mkl/15.3 
module load postg/master 

export PSI_SCRATCH=${TMPDIR}
export PATH=/opt/uovi/alberto/psi4-new/bin/:\${PATH}
export LD_LIBRARY_PATH=/opt/uovi/alberto/psi4-new/lib:\${LD_LIBRARY_PATH}
export LD_RUN_PATH=/opt/uovi/alberto/psi4-new/lib:\${LD_RUN_PATH}
export PYTHONPATH=/opt/uovi/alberto/psi4-new/lib :\${PYTHONPATH}

EOM
}
