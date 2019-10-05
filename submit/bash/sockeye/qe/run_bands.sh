#! /bin/bash

run_bands(){
    cat >&3 <<EOM
##xx## For bands: run the nscf and bands.x
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.nscf.in > ${i}.nscf.out 2>&1
mpiexec --mca mpi_cuda_support 0 bands.x < ${i}.bands.up.in > ${i}.bands.up.out 2>&1
mpiexec --mca mpi_cuda_support 0 bands.x < ${i}.bands.dn.in > ${i}.bands.dn.out 2>&1

EOM
}
