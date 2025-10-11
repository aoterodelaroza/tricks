#! /bin/bash

run_scratch(){
	cat >&3 <<EOM
cp -f ${i}.gjf \${SLURM_TMPDIR}
cd \${SLURM_TMPDIR}
g16 ${i}.gjf
mv ${i}.log $(pwd)
rm -f *.gjf *.log *.chk *.wfx
cd $(pwd)

EOM
}
