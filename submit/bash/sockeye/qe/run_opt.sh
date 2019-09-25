#! /bin/bash

run_opt(){
    cat >&3 <<EOM
##xx## For optimizations: repeat the calculation n times
cp -f ${i}.scf.in ${i}.scf.in1
cp -f ${i}.scf.out ${i}.scf.out1

/home/aoterode/git/tricks/awk/pwout2in.awk ${i}.scf.out ${i}.scf.in > bleh.in
mv bleh.in ${i}.scf.in
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf.in > ${i}.scf.out
cp -f ${i}.scf.in ${i}.scf.in2
cp -f ${i}.scf.out ${i}.scf.out2

/home/aoterode/git/tricks/awk/pwout2in.awk ${i}.scf.out ${i}.scf.in > bleh.in
mv bleh.in ${i}.scf.in
mpiexec --mca mpi_cuda_support 0 pw.x < ${i}.scf.in > ${i}.scf.out
cp -f ${i}.scf.in ${i}.scf.in3
cp -f ${i}.scf.out ${i}.scf.out3

EOM
}
