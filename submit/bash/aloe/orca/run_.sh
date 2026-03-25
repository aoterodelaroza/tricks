#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.inp ${i}.xyz \${SLURM_TMPDIR}
cd \${SLURM_TMPDIR}
\$(which orca) ${i}.inp 2>&1 > $(pwd)/${i}.out ${AMP}
rm -f ${i}.*

EOM
}
