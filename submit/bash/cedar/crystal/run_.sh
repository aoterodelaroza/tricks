#! /bin/bash

run_(){
	cat >&3 <<EOM

#cp -f ${i}.fort.34 \${SLURM_TMPDIR}/fort.34
#cp -f ${i}.d12 \${SLURM_TMPDIR}/
#cp -f ${i}.d12 \${SLURM_TMPDIR}/INPUT
#cd \${SLURM_TMPDIR}
cp -f ${i}.fort.34 fort.34
cp -f ${i}.d12 INPUT

mpirun -np ${ncpu} ~/src/crystal17/bin/Linux-ifort/Pcrystal < ${i}.d12 >& ${i}.out ${AMP}

#cp -f ${i}.out $(pwd)/${i}
#cp -f \$(ls -v optc* | tail -n 1) $(pwd)/${i}
#rm -f *.34 *.d12 *.out opt*

EOM
}
