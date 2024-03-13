#! /bin/bash

run_phonons(){
    cat >&3 <<EOM
mpirun ph.x < ${i}.ph.in > ${i}.ph.out
if [ -f "${i}.dynmat.in" ]; then
  mpirun dynmat.x < ${i}.dynmat.in > ${i}.dynmat.out 2>&1
fi
mpirun q2r.x < ${i}.q2r.in > ${i}.q2r.out 2>&1
mpirun matdyn.x < ${i}.matdyn.in > ${i}.matdyn.out 2>&1

EOM
}
