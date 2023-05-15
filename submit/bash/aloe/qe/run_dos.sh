#! /bin/bash

run_dos(){
    cat >&3 <<EOM
mpirun  \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
mpirun  \$A/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
