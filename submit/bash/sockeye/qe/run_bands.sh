#! /bin/bash

run_bands(){
    cat >&3 <<EOM
##xx## For bands: run the nscf and bands.x
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.nscf.in > ${i}.nscf.out
mpiexec --mca mpi_cuda_support 0 bands.x < ${i}.bands.up.in > ${i}.bands.up.out
mpiexec --mca mpi_cuda_support 0 bands.x < ${i}.bands.dn.in > ${i}.bands.dn.out

EOM
}
