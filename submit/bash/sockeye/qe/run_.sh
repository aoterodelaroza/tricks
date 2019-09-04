#! /bin/bash

run_(){
    cat >&3 <<EOM
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf.in > ${i}.scf.out ${AMP}

EOM
}
