#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.inp \${TMPDIR}
cd \${TMPDIR}
/home/alberto/src/orca_4_2_0/orca ${i}.inp > ${i}.out ${AMP}
orca_2aim ${i}
#postg 1. 1. ${i}.wfx 0.0 > ${i}.pgout
xz ${i}.wfx
mv *.inp *.out *.xz *.pgout $(pwd)
rm -f *.tmp* *.txt *.prop *.inp


EOM
}
