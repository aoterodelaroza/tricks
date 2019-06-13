!#! /bin/bash

run_bands(){
    cat >&3 <<EOM
##xx## For bands: run the nscf and bands.x
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.nscf.in > ${i}.nscf.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/bands.x < ${i}.bands.up.in > ${i}.bands.up.out
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/bands.x < ${i}.bands.dn.in > ${i}.bands.dn.out

EOM
}
