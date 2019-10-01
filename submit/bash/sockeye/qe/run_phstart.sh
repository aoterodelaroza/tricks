#! /bin/bash

run_phstart(){
    cat >&3 <<EOM
export ESPRESSO_TMPDIR=.
sed '/&inputph/a\ start_irr=0,\n\ last_irr=0,' ${i}.ph.in > ${i}.ph.in_start

mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf.in > ${i}.scf.out 
mpiexec --mca mpi_cuda_support 0 ph.x < ${i}.ph.in_start > ${i}.ph.out_start
seq \$(ls _ph0/crystal.phsave/patterns.*xml | wc -l) > qpts.torun

EOM
}

