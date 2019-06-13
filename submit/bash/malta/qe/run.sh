#! /bin/bash

run(){
    cat >&3 <<EOM
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np $NCORE \$ESPRESSO_HOME/bin/pw.x < ${i}.scf.in > ${i}.scf.out

EOM
}
