#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.inp \${SLURM_TMPDIR}/
cd \${SLURM_TMPDIR}/
\$(which orca) ${i}.inp 2>&1 > ${i}.out ${AMP}
mv ${i}.out ${i}.wfn ${i}.wfx $(pwd)
# xz ${i}.gbw

EOM
}
