#! /bin/bash

init_251014(){
    cat >&3 <<EOM
# intel compiler
. /opt/software/intel-2025.3.1.16/setvars.sh

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

# no openmp
export OMP_NUM_THREADS=1
export OMP_PROC_BIND=spread
export OMP_PLACES=threads

# fhiaims
export FHIAIMS=/opt/software/FHIaims_\${NODETYPE}/bin/aims.251014.scalapack.mpi.x

EOM
}
