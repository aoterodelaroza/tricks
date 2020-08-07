#! /bin/bash

run_dos(){
    cat >&3 <<EOM
srun \$A/pw.x < ${i}.nscf.in > ${i}.nscf.out
srun \$A/dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
