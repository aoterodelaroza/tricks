#! /bin/bash

run_(){
	cat >&3 <<EOM
cp ${i}.d12 INPUT
cp ${i}.fort.34 fort.34
mpirun -np ${ncpu} /opt/uovi/alberto/crystal17/bin/Linux-ifort/Pcrystal < ${i}.d12 >& ${i}.out ${AMP}

EOM
}
