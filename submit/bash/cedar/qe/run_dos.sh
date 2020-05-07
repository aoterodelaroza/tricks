#! /bin/bash

run_dos(){
    cat >&3 <<EOM
mpirun -np ${ncpu} \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
mpirun -np ${ncpu} \$A/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
