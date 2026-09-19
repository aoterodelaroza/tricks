#! /bin/bash

run_scratch(){
    cat >&3 <<EOM
mkdir -p \${SLURM_TMPDIR}/${i}
cp -f * \${SLURM_TMPDIR}/${i}/ 2> /dev/null
cd \${SLURM_TMPDIR}/${i}
mpirun \$GULP < ${i}.gin > ${i}.gout
cp -f * $(pwd)/${i}/ 2> /dev/null
cd $(pwd)/${i}

EOM
}
