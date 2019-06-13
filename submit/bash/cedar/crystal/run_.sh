#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.d12 INPUT
## cp -f ../../empty/${i}/fort.9 fort.20
mpirun -np ${nmpi} ~/src/crystal17/bin/Linux-ifort/Pcrystal < ${i}.d12 >& ${i}.out ${AMP}

EOM
}
