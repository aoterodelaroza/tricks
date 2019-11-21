#! /bin/bash

run_dos(){
    cat >&3 <<EOM
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/pw.x < ${i}.nscf.in > ${i}.nscf.out 
/opt/openmpi/1.8.4/bin/mpirun --mca btl_sm_use_knem 0 --mca btl_vader_single_copy_mechanism none -np ${ncpu} \$ESPRESSO_HOME/bin/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
