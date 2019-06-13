!#! /bin/bash

run_opt(){
    cat >&3 <<EOM
##xx## For optimizations: repeat the calculation n times
cp -f ${i}.scf.in ${i}.scf.in1
cp -f ${i}.scf.out ${i}.scf.out1

/home/alberto/bin/pwout2in.awk ${i}.scf.out ${i}.scf.in > bleh.in
mv bleh.in ${i}.scf.in
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.scf.in > ${i}.scf.out
cp -f ${i}.scf.in ${i}.scf.in2
cp -f ${i}.scf.out ${i}.scf.out2

/home/alberto/bin/pwout2in.awk ${i}.scf.out ${i}.scf.in > bleh.in
mv bleh.in ${i}.scf.in
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.scf.in > ${i}.scf.out
cp -f ${i}.scf.in ${i}.scf.in3
cp -f ${i}.scf.out ${i}.scf.out3

EOM
}
