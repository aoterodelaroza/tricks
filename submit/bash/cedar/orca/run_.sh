#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.inp \${SLURM_TMPDIR}
cd \${SLURM_TMPDIR}
/home/alberto/src/orca_4_0_1/orca ${i}.inp > ${i}.out ${AMP}
xz ${i}.gbw
rm -f *.tmp* *.txt *.prop *.inp
mv ${i}.gbw.xz *.out $(pwd)

EOM
}
