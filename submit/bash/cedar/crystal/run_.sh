#! /bin/bash

run_(){
	cat >&3 <<EOM

cp -f ${i}.fort.34 \${SLURM_TMPDIR}/fort.34
cp -f ${i}.d12 \${SLURM_TMPDIR}/
cp -f ${i}.d12 \${SLURM_TMPDIR}/INPUT
cd \${SLURM_TMPDIR}
mpirun -np ${ncpu} ~/src/crystal17/bin/Linux-ifort/Pcrystal < ${i}.d12 >& ${i}.out ${AMP}
cp -f ${i}.out $(pwd)/${i}
cp -f optc* $(pwd)/${i}
rm -f *.34 *.d12 *.out opt*

EOM
}
