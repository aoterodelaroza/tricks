#! /bin/bash

run_phend(){
    this=$(pwd)

    cat >&3 <<EOM
export ESPRESSO_TMPDIR=.
sed '/&inputph/a\ recover=.true.,' ${i}.ph.in > ${i}.ph.in_end
rm -f _ph0/*.recover* > /dev/null

mpiexec --mca mpi_cuda_support 0 ph.x < ${i}.ph.in_end > ${i}.ph.out_end 2>&1

if [ -f "${i}.dynmat.in" ]; then
  mpiexec --mca mpi_cuda_support 0 dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out 2>&1
fi
mpiexec --mca mpi_cuda_support 0 q2r.x < ${i}.q2r.in > ${i}.q2r.out 2>&1
mpiexec --mca mpi_cuda_support 0 matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out 2>&1

EOM
}

