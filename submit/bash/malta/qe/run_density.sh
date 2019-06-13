#! /bin/bash

run_density(){
    cat >&3 <<EOM
##xx## For density: use pp.x on .rho.in and on .rhoae.in
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pp.x < ${i}.rho.in > ${i}.rho.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pp.x < ${i}.rhoae.in > ${i}.rhoae.out

EOM
}
