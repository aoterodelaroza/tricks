#! /bin/bash

run_opt(){
    cat >&3 <<EOM
## instructions for MKL
export MKL_DEBUG_CPU_TYPE=5
export MKL_ENABLE_INSTRUCTIONS=AVX512

## run with srun to prevent overlap
export PMIX_MCA_psec=^munge
export PMIX_MCA_gds=^shmem2

##xx## For optimizations: repeat the calculation n times
cp -f ${i}.scf.in ${i}.scf.in1
cp -f ${i}.scf.out ${i}.scf.out1

/home/alberto/bin/pwout2in.awk ${i}.scf.out ${i}.scf.in > bleh.in
mv bleh.in ${i}.scf.in
srun  \$A/pw.x < ${i}.scf.in > ${i}.scf.out
cp -f ${i}.scf.in ${i}.scf.in2
cp -f ${i}.scf.out ${i}.scf.out2

/home/alberto/bin/pwout2in.awk ${i}.scf.out ${i}.scf.in > bleh.in
mv bleh.in ${i}.scf.in
srun  \$A/pw.x < ${i}.scf.in > ${i}.scf.out
cp -f ${i}.scf.in ${i}.scf.in3
cp -f ${i}.scf.out ${i}.scf.out3

EOM
}
