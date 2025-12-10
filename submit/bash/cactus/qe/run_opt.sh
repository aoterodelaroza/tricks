#! /bin/bash

run_opt(){
    cat >&3 <<EOM
##xx## For optimizations: repeat the calculation n times
mpirun \$A/pw.x < ${i}.scf.in > ${i}.scf.out
mv ${i}.scf.in ${i}.scf.in1
mv ${i}.scf.out ${i}.scf.out1

\$A/tools/pwout2in.awk ${i}.scf.out1 ${i}.scf.in1 > ${i}.scf.in
mpirun \$A/pw.x < ${i}.scf.in > ${i}.scf.out
mv ${i}.scf.in ${i}.scf.in2
mv ${i}.scf.out ${i}.scf.out2

\$A/tools/pwout2in.awk ${i}.scf.out2 ${i}.scf.in2 > ${i}.scf.in
mpirun \$A/pw.x < ${i}.scf.in > ${i}.scf.out

EOM
}
