#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.inp \${TMPDIR}
cd \${TMPDIR}
/home/alberto/src/orca_4_2_0/orca ${i}.inp > ${i}.out ${AMP}
orca_2mkl ${i} -molden
mv ${i}.molden.input ${i}.molden
xz ${i}.gbw ${i}.molden
mv ${i}.gbw.xz ${i}.molden.xz *.out $(pwd)
rm -f *.tmp* *.txt *.prop *.inp


EOM
}
