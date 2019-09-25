#! /bin/bash

run_(){
	cat >&3 <<EOM
mpiexec --mca mpi_cuda_support 0 lmp_mpi -in ${i}.lmp -log ${i}.log > ${i}.out

EOM
}
