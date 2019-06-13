#! /bin/bash

run_phonons(){
    cat >&3 <<EOM
##xx## For phonons: run ph.x and the rest of the programs
mpirun -np ${ncpu} \$A/ph.x < ${i}.ph.in > ${i}.ph.out
if [ -f "${i}.dynmat.in" ]; then
  mpirun -np ${ncpu} \$A/dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out
fi
mpirun -np ${ncpu} \$A/q2r.x < ${i}.q2r.in > ${i}.q2r.out
mpirun -np ${ncpu} \$A/matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out

EOM
}
