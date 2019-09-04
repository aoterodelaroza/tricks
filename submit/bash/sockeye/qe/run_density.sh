#! /bin/bash

run_density(){
    cat >&3 <<EOM
##xx## For density: use pp.x on .rho.in and on .rhoae.in
mpiexec --mca mpi_cuda_support 0 pp.x < ${i}.rho.in > ${i}.rho.out
mpiexec --mca mpi_cuda_support 0 pp.x < ${i}.rhoae.in > ${i}.rhoae.out

EOM
}
