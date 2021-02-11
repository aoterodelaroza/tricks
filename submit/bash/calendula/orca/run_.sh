#! /bin/bash

run_(){
	cat >&3 <<EOM
newdir=\$(mktemp -d ${i}_XXXXXXXX)
cp -f ${i}.inp \$newdir
cd \$newdir
/soft/calendula2/sandybridge/ORCA/4.2.0/orca ${i}.inp > ${i}.out ${AMP}
orca_2mkl ${i} -molden
orca_2mkl ${i} 
mv ${i}.molden.input ${i}.molden
xz ${i}.gbw ${i}.molden ${i}.wfx ${i}.wfn
mv ${i}.inp ${i}.out *.xz ..
cd ..
rm -r \$newdir

EOM
}
