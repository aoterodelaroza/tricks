#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.inp \$TMPDIR
cd \$TMPDIR
/home/aoterode/src/orca_5_0_3/orca ${i}.inp > ${i}.out ${AMP}

EOM
}
