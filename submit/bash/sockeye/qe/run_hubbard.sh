#! /bin/bash

run_hubbard(){
    cat >&3 <<EOM
##xx## For hubbard: run the scf, scf2, and hp
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf2.in > ${i}.scf2.out
mpiexec --mca mpi_cuda_support 0 hp.x < ${i}.hp.in > ${i}.hp.out

EOM
}
