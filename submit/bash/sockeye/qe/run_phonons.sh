#! /bin/bash

run_phonons(){
    cat >&3 <<EOM
##xx## For phonons: run ph.x and the rest of the programs
mpiexec --mca mpi_cuda_support 0 ph.x < ${i}.ph.in > ${i}.ph.out
if [ -f "${i}.dynmat.in" ]; then
  mpiexec --mca mpi_cuda_support 0 dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out
fi
mpiexec --mca mpi_cuda_support 0 q2r.x < ${i}.q2r.in > ${i}.q2r.out
mpiexec --mca mpi_cuda_support 0 matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out

EOM
}
