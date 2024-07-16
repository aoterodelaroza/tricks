#! /bin/bash

run_phonons(){
    cat >&3 <<EOM

##xx## For phonons: run ph.x and the rest of the programs
srun  ph.x < ${i}.ph.in > ${i}.ph.out
if [ -f "${i}.dynmat.in" ]; then
  srun  dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out
fi
srun  q2r.x < ${i}.q2r.in > ${i}.q2r.out
srun  matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out

EOM
}
