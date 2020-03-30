#! /bin/bash

run_neb(){
    cat >&3 <<EOM
##xx## Use neb.x
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/neb.x -i ${i}.neb.in > ${i}.neb.out

EOM
}
