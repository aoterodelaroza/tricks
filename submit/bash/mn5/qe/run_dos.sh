#! /bin/bash

run_dos(){
    cat >&3 <<EOM
srun  pw.x < ${i}.nscf.in > ${i}.nscf.out
srun  dos.x < ${i}.dos.in > ${i}.dos.out

EOM
}
