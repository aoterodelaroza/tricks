#! /bin/bash

run_basic(){
    cat >&3 <<EOM
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf.in > ${i}.scf.out 2>&1 ${AMP}

EOM
}
