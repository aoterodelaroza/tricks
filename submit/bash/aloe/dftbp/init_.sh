#! /bin/bash

init_(){
    cat >&3 <<EOM
# intel compiler
. /opt/software/intel-oneapi-2025.3.0.381/setvars.sh

# openmpi
export PATH=/opt/software/openmpi-4.1.8_intel/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/openmpi-4.1.8_intel/lib/:\$LD_LIBRARY_PATH
export MANPATH=/opt/software/openmpi-4.1.8_intel/share/man/:\$MANPATH
export OMPI_MCA_btl='^openib'
export OMPI_MCA_btl_openib_warn_no_device_params_found=0

# mkl
export MKLROOT=/opt/software/intel_mkl-2025.3.0.462/mkl/2025.3
export LD_LIBRARY_PATH=\$MKLROOT/lib/intel64:\$LD_LIBRARY_PATH
export MKL_LIB=\$MKLROOT/lib/intel64
export MKL_INCLUDE=\$MKLROOT/include
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE

# openmp
export OMP_NUM_THREADS=\${ncpu}

# dftbp
export PATH=/opt/software/dftbplus-25.1/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/dftbplus-25.1/bin/:\$LD_LIBRARY_PATH

EOM
}
