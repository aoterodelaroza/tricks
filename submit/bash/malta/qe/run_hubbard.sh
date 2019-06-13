!#! /bin/bash

run_hubbard(){
    cat >&3 <<EOM
##xx## For hubbard: run the scf, scf2, and hp
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.scf2.in > ${i}.scf2.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/hp.x < ${i}.hp.in > ${i}.hp.out

EOM
}
