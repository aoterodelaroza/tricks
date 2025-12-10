#! /bin/bash

run_(){
	cat >&3 <<EOM
cp -f ${i}.fort.34 ${i}.d12 ${i}.d3 \${SLURM_TMPDIR} 2>&1 > /dev/null
cd \${SLURM_TMPDIR}

cp -f ${i}.fort.34 fort.34 2>&1 > /dev/null
cp -f ${i}.d12 INPUT
/usr/bin/mpirun /opt/software/crystal17/bin/Linux-gfortran_openmpi/v1.0.2/Pcrystal < ${i}.d12 >& $(pwd)/${i}/${i}.out
mv fort.34 $(pwd)/${i}/${i}.end.fort.34

# cp -f ${i}.d3 INPUT
# /usr/bin/mpirun /opt/software/crystal17/bin/Linux-gfortran_openmpi/v1.0.2/Pproperties < ${i}.d3 >& $(pwd)/${i}/${i}.d3out

EOM
}
