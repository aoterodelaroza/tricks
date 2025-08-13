#! /bin/bash

run_(){
	cat >&3 <<EOM
cp ${i}.inp \${SLURM_TMPDIR}
cd \${SLURM_TMPDIR}
\$(which orca) ${i}.inp 2>&1 > $(pwd)/${i}.out ${AMP}
# orca_2aim ${i}
# mv ${i}.wfx $(pwd)
# xz ${i}.gbw

EOM
}
