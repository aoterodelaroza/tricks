#! /bin/bash

init_651(){
    cat >&3 <<EOM
# MKL trick on AMD gives wrong VASP results unless CBWR is pinned (see /opt/software/vasp-6.5.1_sie_ladon/BUILD_NOTES.md)
if [ "\$NODETYPE" == "sie_ladon" ]; then
   export MKL_CBWR=AVX2
fi

# intel compiler
. /opt/software/intel-2025.3.1.16/setvars.sh > /dev/null

# openmpi
export PATH=/opt/software/openmpi-4.1.8_intel/bin/:\$PATH
export LD_LIBRARY_PATH=/opt/software/openmpi-4.1.8_intel/lib/:\$LD_LIBRARY_PATH
export MANPATH=/opt/software/openmpi-4.1.8_intel/share/man/:\$MANPATH
export OMPI_MCA_btl='^openib'
export OMPI_MCA_btl_openib_warn_no_device_params_found=0

# mkl
export MKLROOT=/opt/software/intel_mkl-2025.3.0.462/mkl/2025.3
export LD_LIBRARY_PATH=\$MKLROOT/lib/intel64:\$LD_LIBRARY_PATH
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE

# no openmp
export OMP_NUM_THREADS=1
export OMP_STACKSIZE=512m
export OMP_PLACES=cores
export OMP_PROC_BIND=close

# vasp
export VASP_HOME=/opt/software/vasp-6.5.1_\${NODETYPE}
A=\${VASP_HOME}/bin

EOM
}
