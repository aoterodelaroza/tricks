#! /bin/bash

run_pack(){
	cat >&3 <<EOM
rm -r \${SLURM_TMPDIR}/*.log
cp -f ${i}.tar.xz \${SLURM_TMPDIR}
cd \${SLURM_TMPDIR}
tar xf ${i}.tar.xz
rm -f ${i}.tar.xz
for jj in *.gjf ; do
  j=\${jj%.gjf}
  g16 \${j}.gjf
  #sed -i -n '/Done/p;\$p' \${j}.log
  rm -f \${j}.chk
done
tar cJf ${i}.tar.xz *.log
mv ${i}.tar.xz $(pwd)
rm -f *.gjf *.log *.chk *.wfx
cd $(pwd)
touch ${i}.done

EOM
}
