#! /bin/bash

run_(){
	cat >&3 <<EOM
/soft/calendula2/sandybridge/ORCA/4.2.0/orca ${i}.inp > ${i}.out ${AMP}
orca_2mkl ${i} -molden
mv ${i}.molden.input ${i}.molden
xz ${i}.gbw ${i}.molden ${i}.wfx
rm -f *.tmp* *.txt *.prop *.wfn


EOM
}
