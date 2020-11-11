#! /bin/bash

init_qe65thermo(){
    cat >&3 <<EOM
export I_MPI_ROOT=/LUSTRE/SOFT/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mpi
export MKLROOT=/LUSTRE/SOFT/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mkl
export FI_PROVIDER=verbs
export FI_PROVIDER_PATH=/LUSTRE/SOFT/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/libfabric/lib/prov
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so
export I_MPI_PMI=pmi2
export LD_LIBRARY_PATH=/soft/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/compiler/lib/intel64_lin:/soft/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/lib:/soft/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/lib/release:/soft/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/libfabric/lib:/soft/calendula2/intel/ipsxe_2020_u1/compilers_and_libraries_2020.1.217/linux/mkl/lib/intel64_lin:\$LD_LIBRARY_PATH

export ESPRESSO_TMPDIR=.
export ESPRESSO_HOME=/home/udo97/udo97373/src/espresso-6.5_thermo/
export PATH=\${ESPRESSO_HOME}/bin:\$PATH
A=\$ESPRESSO_HOME/bin

EOM
}
